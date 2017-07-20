clear all;
dd7 = struct();
dd7 = setfield(dd7,{1},"a",1);
dd7 = setfield(dd7,{2},"b",1);
dd7 = setfield(dd7,{3},"c",1);

dd = struct();
dd = setfield(dd,{1},"dd1", {1, 4}, 1);
dd = setfield(dd,{2},"dd2", {1, 4}, 2);
dd = setfield(dd,{3},"dd3", {1, 4}, 3);
dd = setfield(dd,{4},"dd4", {1, 4}, 4);
dd = setfield(dd,{5},"dd5", {1, 4}, 5);
dd = setfield(dd,{6},"dd6", {1, 4}, 6);
dd = setfield(dd,{7},"dd7", dd7);


function displayStruct(x)
  printf("test");
  if isstruct(x)
    fields=fieldnames(x);
    disp(fields);
    for i=1:numel(fields)
      disp(i);
      f = x.(fields{i});
      typeinfo(f)
      displayStruct(f);
      
    endfor
  endif


endfunction


function buildMatrix(x)

  for p=1:length(x)
  
    if(isstruct(x(p)))
      fields=fieldnames(x(p));
      disp(fields);
      for i=1:numel(fields)
        f = x(p).(fields{i});
        buildMatrix(f);
      endfor
    endif
   
  endfor
endfunction


#displayStruct(dd)
load Resources/Battery/B0005.mat;
#displayStruct(B0005)
buildMatrix(B0005);