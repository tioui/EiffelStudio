indexing

description: "Root class and driver for the compiler";
keywords: "root class", "driver";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PRETTYTEST

inherit
    ARGUMENTS;
    THE_HANDLER
    THE_TABLE

creation
    make

feature

    make is

        local
            n       : INTEGER
            read    : IDL_FILE_READER
            scan    : IDL_SCANNER
            intf    : PLAIN_TEXT_FILE
            outf    : PLAIN_TEXT_FILE
            path    : STRING
            idlpath : STRING
            project : STRING
            pref    : STRING
            sp      : SPECIFICATION_PARSER
            s       : SPECIFICATION
            ppv     : PRETTY_PRINTER_VISITOR
            unv     : UNDEFINED_NAME_VISITOR
            argc    : INTEGER_REF
            opts    : DICTIONARY [STRING, STRING]
            o       : INDEXED_CATALOG [STRING, STRING]
            oparser : GET_OPTS
            ipaths  : INDEXED_LIST [STRING]
            err     : BOOLEAN
            r       : BOOLEAN

        do
            if argument_count = 0 then
                    print_usage
                    err := true
            end
            if not err then
                create opts.make
                opts.put ("unique", "-o")
                opts.put ("nonunique", "-I")
                opts.put ("", "--help")
                create argc
                argc.set_item (argument_count)
                create oparser.make (opts)
                o := oparser.opts
                err := not oparser.parse3 (argc, argument_array, true)
             end

             if not err and then o.has ("--help") then
                print_usage
                err := true
                    -- Of course this not an error, but it's
                    -- the only clean way to exit.                
             end

             if not err then
                if argc.item = 0 then
                    io.put_string ("%NMissing idl-path%N")
                    print_usage
                    err := true
                else
                    if o.has ("-I") then
                        ipaths := o.at ("-I")
                    else
                        create ipaths.make (false)
                    end
                end
            end

            if not err then
                idlpath := argument_array.item (1)
                n       := idlpath.count
                if  n > 3 and then
                    equal (idlpath.substring(n - 3, n), ".idl") then
                    idlpath := idlpath.substring (1, n - 4)
                end
                path    := clone (idlpath)
                if o.has ("-o") then
                    pref:= o.at ("-o").at (1)
                else
                    pref := "."
                end
                project := fs.path_suffix (path)
                project.to_lower
                path.append (".idl")

                if not fs.file_exists (path) then
                    err := true
                    io.put_string ("The file ")
                    io.put_string (path)
                    io.put_string (" does not exist%N")
                end

                if not err and then
                   not fs.has_readperm (path) then
                    err := true
                    io.put_string ("You don't have read %
                                   %permission for ")
                    io.put_string (path)
                    io.new_line
                end


                if not err then
                    create intf.make_open_read (path)
                    create read.make
                    read.set_text (intf)
                    create scan.make (read)  
                    error_handler.set_scanner (scan)
                    error_handler.set_generation (false)
                    create sp.make (project, ipaths)
                    sp.parse (scan)
                    intf.close
                    error_handler.set_generation (true)
                    io.put_string ("%NParsing completed%N")
                    path := fs.concat_paths (pref, "pretty.idl")
                    create outf.make_open_write (path)
                    io.set_file_default (outf)
                    create ppv
                    sp.value.accept (ppv)
                    outf.close
                    io.set_output_default
                    io.put_string ("DONE%N")
                    create unv
                    sp.value.accept (unv)
                    unv.finish
                end -- if not err then ... (inner)
            end -- if not err then ... (outer)

        rescue
            io.set_output_default
            if error_handler.in_text then
                io.new_line
                io.put_string (error_handler.text)
                io.new_line
                draw_arrow (error_handler.column)
                io.new_line
                io.put_string (error_handler.error_text)
                io.put_string ("%Nin line ")
                io.putint (error_handler.line)
                io.put_string (" of file ")
                io.put_string (error_handler.path)
                io.new_line
            elseif error_handler.generation then
                io.new_line
                io.put_string (error_handler.error_text)
                io.new_line
            elseif not err then
                io.put_string ("Runtime error in routine%N")
                io.put_string (except.class_name)
                io.putchar ('.')
                io.put_string (except.recipient_name)
                io.put_string ("%NExplanation : ")
                io.put_string (except.meaning (except.exception))
                io.put_string ("%NTag : ")
                io.put_string (except.tag_name)
                if equal (except.tag_name, "WARNING:%N") then
                    io.put_string (error_handler.error_text)
                end
                io.new_line
            end
            if intf /= void   and then
               not intf.is_closed then
                intf.close
            end
            err := true
            retry
        end
----------------------

    draw_arrow (col : INTEGER) is

        local
            i : INTEGER

        do
            from
                i := 1
            until
                i >= col
            loop
                io.putchar ('_')
                i := i + 1
            end
            io.putchar ('^')
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end
----------------------

    fs : FILE_SYSTEM is

        once
            create result.make
        end
----------------------

    error (msgs : ARRAY [STRING]) is

        local
            i : INTEGER
            m : STRING

        do
            from
                i := msgs.lower
                m := msgs.item (i)
                i := i + 1
            until
                i > msgs.upper
            loop
                m.append (msgs.item (i))
                i := i + 1               
            end
            error_handler.error (m, false)
        end
----------------------

    print_usage is

        local
            command : STRING

        do
            command := fs.path_suffix (command_name)
            io.put_string ("Usage: ")
            io.put_string (command)
            io.put_string (" [-o <out-path>] (-I <include-path>)* %
                           %<idl-path>%N")
        end

end -- class PRETTYTEST

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
