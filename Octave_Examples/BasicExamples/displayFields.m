#{
function displayFields (data , indent = "")
  main_fields = fieldnames(data);
  main_fields_count = numel(main_fields);
  if(isempty(indent))
    printf("%s: ", inputname(1))
  endif
  if(isstruct(data))
    printf ("structure containing the fields:\n");
    indent = [indent "  "]
    nn = fieldnames (data)
    for ii = 1:numel(nn)
      if (isstruct (data.(nn{ii})))
        printf ("%s %s: ", indent, nn{ii})
        displayfields (data.(nn{ii}), indent)
      else
        printf ("%s %s\n", indent, nn{ii})
      endif
    endfor
    else
    display ("not a structure");
  endif  
  #fields = fieldnames(data.(main_fields{1}));
endfunction
#}


function displayFields(data, indent = "")
struct_levels_to_print (1000, "local")
print_struct_array_contents (1000, "local")
 if(isempty(indent))
    printf("%s: ", inputname(1))
  endif
  if(isstruct(data))
    printf("structure containing the fields:\n");
   indent = [indent "  "]
    nn = fieldnames (data);
    for ii = 1:numel(nn)
    disp(ii);
      printf("%s\n",ii);
      y = data.(nn{ii});
      if (isstruct (y))
        printf ("%s %s: \n",indent, nn{ii});
        #disp(data.(nn{ii}))
        mm = fieldnames(y);
        disp(numel(mm));
        displayFields (data.(nn{ii}),indent);
      else
        printf ("%s %s\n", indent, nn{ii});
      endif
    endfor
     
  else
   
     display ("not a structure");
  endif
endfunction