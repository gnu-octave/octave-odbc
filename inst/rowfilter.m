## Copyright (C) 2023-2024 John Donoghue <john.donoghue@ieee.org>
##
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

classdef rowfilter
  ## -*- texinfo -*- 
  ## @deftypefn {} {@var{rowfilt} =} rowfilter(@var{C})
  ## @deftypefnx {} {@var{rowfilt} =} rowfilter(@var{T})
  ## Create an unconstrained rowfilter object with columns names.
  ##
  ## @subsubheading Inputs
  ## @table @asis
  ## @item @var{C}
  ## A column name, cell array of column names.
  ## @item @var{T}
  ## A table to use for column names.
  ## @end table
  ##
  ## @subsubheading Outputs
  ## @table @asis
  ## @item @var{rowfilt}
  ## a rowfilter object
  ## @end table
  ##
  ## @subsubheading Object Properties
  ## Object properties are the names of the columns on creation of the filter.
  ##
  ## Constraints can be set on a specific field of the filter by setting a
  ## comparison value for the variable name.
  ##
  ## @subsubheading Examples
  ## @example
  ## @code {
  ## # create a rowfilter with 2 columns
  ## rf = rowfilter(@{'Column1', 'Column2'@});
  ## # add a constraint for Column1 > 10
  ## rfc = rf.Column1 > 10
  ## }
  ## @end example
  ##
  ## @end deftypefn

  properties (Access = private)
    # internal data store
    vars = [];
    constraints = [];
  endproperties

  methods (Static = true, Access = private, Hidden = true)

    function v = no_op_change (c, v='')
      v = [ " " c " " ];
    endfunction

    function v = sql_op_change (c, v='')
      if strcmp(c, "&")
       c = "AND";
      endif
      if strcmp(c, "|")
       c = "OR";
      endif
      if strcmp(c, "==")
       c = "=";
       if isnumeric(v) && isempty(v)
         c = "IS";
       endif
      endif
      if strcmp(c, "!=")
       c = "<>";
       if isnumeric(v) && isempty(v)
         c = "IS NOT";
       endif
      endif
      v = [ " " c " " ];
    endfunction

    function s = str_constraint(c, opconv = [])
      if nargin == 1
        opconv = @rowfilter.no_op_change;
      endif
      s = "";
      if iscell(c)
        if length(c) > 1, s = "( ";, endif;
        for x = 1:length(c)
          v = c{x};
          if x > 1, s = [s opconv("&")];, endif;
          s = [s rowfilter.str_constraint(v, opconv)];
        endfor
        if length(c) > 1, s = [s " )"'];, endif;
      else
        if isfield(c, "value1")
          if !isempty(c.value1)
            s = " ( ";
            s = [s rowfilter.str_constraint(c.value1, opconv)];
          endif
          s = [s opconv(c.operation)];
          s = [s rowfilter.str_constraint(c.value2, opconv)];
          if !isempty(c.value1)
            s = [s " )"];
          endif
        elseif isnumeric(c.value)
          if isempty(c.value)
            if opconv == @rowfilter.sql_op_change
              s = sprintf("%s %s %s", c.field, opconv(c.operation, c.value), "NULL");
            else
              s = sprintf("%s %s %s", c.field, opconv(c.operation), "[]");
            endif
          else
            s = sprintf("%s %s %s", c.field, opconv(c.operation), num2str(c.value));
          endif
        else
          s = sprintf("%s %s '%s'", c.field, opconv(c.operation), c.value);
        endif
      endif
    endfunction
 
  endmethods

  methods (Access = public)
    function this = rowfilter (varargin)
      if nargin != 1
        error("Expected variableNames");
      endif

      if iscellstr(varargin{1})
        this.vars = varargin{1};
      elseif ischar(varargin{1})
        this.vars = { varargin{1} };
      elseif isa(varargin{1}, "dbtable")
        t = varargin{1};
        this.vars = t.Properties.VariableNames;
      else
        error ("Unknown or unsupported rowfilter input");
      endif
    endfunction

    function disp (this)
      if isempty(this.constraints)
        printf ("  RowFilter with no constraints\n\n");
      else
        printf ("  RowFilter with constraints\n\n");
        printf("  %s\n\n", this.str_constraint(this.constraints));
      endif
      printf ("  VariableNames:");
      printf(" %s", this.vars{:});
      printf("\n");
    endfunction

    function tf = isempty (this)
      # return true is filter has no contraints set
      tf = isempty(this.constraints);
    endfunction

    function val = subsref (this, s)
      val = "";
      if s(1).type == "."
        field = s(1).subs;

	if ! any(strcmp(this.vars, field))
          error ("Unknown variableName '%s'", field);
	endif

	val = rowfilter(field);
      else
        error("Unsupported subsref '%s'", s(1).type);
      endif

      if (numel (s) > 1)
        val = subsref (val, s(2:end));
      endif
 
    endfunction

    function tf = gt(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
        s = {}; s.field = V; s.operation = ">"; s.value = v;
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function tf = ge(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
        s = {}; s.field = V; s.operation = ">="; s.value = v;
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function tf = lt(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
        s = {}; s.field = V; s.operation = "<"; s.value = v;
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function tf = le(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
        s = {}; s.field = V; s.operation = "<="; s.value = v;
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function tf = eq(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
	s = {}; s.field = V; s.operation = "=="; s.value = v; #: note change to '='
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function tf = ne(this, v)
      tf = false;
      if size(this.vars) == [1 1]
        V = this.vars{1,1};
        s = {}; s.field = V; s.operation = "!="; s.value = v;
	tf = rowfilter(this.vars);
	tf.constraints{end+1} = s;
      endif
    endfunction

    function val = not(this)
      vars1 = this.vars;
      val = rowfilter(vars1);

      const1 = this.constraints;

      if !isempty(const1)
        const = {};
        const.field = "";
        const.operation = "~";
        const.value2 = const1;
        const.value1 = {};
        val.constraints = {const}; 
      endif
    endfunction
 
    function val = and(this, v)
      if isa(v, "rowfilter") == false
        error ("Expected a rowfilter")
      endif
      vars1 = this.vars;
      vars2 = v.vars;
      vars = unique({vars1{:} vars2{:}});
      val = rowfilter(vars);

      const1 = this.constraints;
      const2 = v.constraints;

      const = {};
      const.field = "";
      const.operation = "&";
      const.value1 = const1;
      const.value2 = const2;
      val.constraints = {const}; #{const1{:}, const2{:}};
 
    endfunction

    function val = or(this, v)
      if isa(v, "rowfilter") == false
        error ("Expected a rowfilter")
      endif
      vars1 = this.vars;
      vars2 = v.vars;
      vars = unique({vars1{:} vars2{:}});
      val = rowfilter(vars);
      const1 = this.constraints;
      const2 = v.constraints;
      const = {};
      const.field = "";
      const.operation = "|";
      const.value1 = const1;
      const.value2 = const2;
      val.constraints = {const}; #{const1{:}, const2{:}};
    endfunction

    function val = char(this)
      val = rowfilter.str_constraint(this.constraints, @rowfilter.sql_op_change);
    endfunction
  endmethods
endclassdef

%!error <Expected variableNames> rowfilter();
%!error <Unknown or unsupported rowfilter input> rowfilter(1);

%!test
%! rf = rowfilter('Column1');
%! assert(properties(rf), {'Column1'});
%! assert(isempty(rf))

%!test
%! rf = rowfilter({'Column1', 'Column2'});
%! assert(properties(rf), {'Column1', 'Column2'});

%!test
%! rf = rowfilter({'Column1', 'Column2'});
%! r2 = rf.Column1 > 10;
%! assert(properties(r2), {'Column1'})
%! assert(!isempty(r2))

%!test
%! rf = rowfilter({'Column1', 'Column2'});
%! fail("rf.Column12 > 10")
