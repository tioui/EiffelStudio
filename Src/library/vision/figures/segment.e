--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- SEGMENT: Description of segements (implementation for X).

class SEGMENT 

inherit

	LINE
		rename
			make as line_make
		redefine
			contains
		end;

	ENDED

creation

	make
	
feature 

	make is
			-- Create current segment.
		do
			line_make;
			!! p1;
			!! p2
		end;

   	contains (p: COORD_XY_FIG): BOOLEAN is
         -- Is `p' on segment?
      require else
         point_exists: not (p = Void)
      local
         t, rsq, dx, dy, dpx, dpy: REAL;
      do
		
         if p1.x /= p2.x or p1.y /= p2.y then
                dx  := p2.x - p1.x;
                dy  := p2.y - p1.y;
                dpx := p1.x - p.x;
                dpy := p1.y - p.y;
                t   := - (dpx*dx + dpy*dy) / (dx*dx + dy*dy);
                dpx := dpx + t*dx;
                dpy := dpy + t*dy;
                rsq := dpx*dpx + dpy*dpy;
                Result := rsq <= line_width*line_width/4.0
         else
             Result := p.x = p1.x and p.y = p1.y
         end
      end;

	draw is
			-- Draw the segment.
		require else
			drawing_attached: not (drawing = Void)
		do
			if drawing.is_drawable then
				drawing.set_cap_style (cap_style);
				set_drawing_attributes (drawing);
				drawing.draw_segment (p1, p2)
			end
		end;

	is_null: BOOLEAN is
			-- Is the segment null ?
		do
			Result := p1.is_surimposable (p2)
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the line surimposable to `other' ?
		require else
			other_exists: not (other = Void)
		do
			Result := (p1.is_surimposable (other.p1) and p2.is_surimposable (other.p2)) or else (p1.is_surimposable (other.p2) and p2.is_surimposable (other.p1))
		end;

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require else
			o1_exists: not (o1 = Void);
			o2_exists: not (o2 = Void)
		do
			p1 := o1;
			p2 := o2
		ensure then
			p1 = o1;
			p2 = o2
		end;

	set_p1 (p: like p1) is
			-- Set the first point.
		require else
			p_exists: not (p = Void)
		do
			p1 := p
		ensure then
			p1 = p
		end;

	set_p2 (p: like p2) is
			-- Set the second point.
		require else
			p_exists: not (p = Void)
		do
			p2 := p
		ensure then
			p2 = p
		end;

end
