#! octave-interpreter-name -qf
# an Octave program which reads structure array of Battery data (mat format) from NASA
# https://ti.arc.nasa.gov/tech/dash/pcoe/prognostic-data-repository/#battery
# loadpath(directory containing mat file)

1;

clear all;

function retval = fact (n)
  if (n > 0)
    retval = n * fact (n-1);
  else
    retval = 1;
  endif
endfunction

function displayFieldsa (data , indent = "")
  #main_fields = fieldnames(data);
  #main_fields_count = numel(main_fields);
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

load Resources/Battery/B0005.mat;
nn = fieldnames (B0005);
y = B0005.(nn{1});
displayFields (y);


