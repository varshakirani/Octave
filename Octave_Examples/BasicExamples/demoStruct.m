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

disp(x);
  for p=1:length(x)
  
    
    if(isstruct(x(p)))
      fields=fieldnames(x(p));
      #disp(fields);
      for i=1:numel(fields)
        f = x(p).(fields{i});
        buildMatrix(f);
      endfor
    endif
   
  endfor
endfunction

function buildM(x)
fid=fopen('myFile.csv','at');
fprintf(fid,'%s,%s,%s,%s,%s\n',"type","temperature","startTime","fieldname","data");
fclose(fid);
#fprintf(fid,'%s,%d,%s',type,temp,datestr(time))
  for p=1:length(x)
  #for p=1:1 
   #disp(x(p));
    disp(p)
    type=getfield(x(p),"type");
    temp=getfield(x(p),"ambient_temperature");
    time=getfield(x(p),"time");
    data=getfield(x(p),"data");
    if(strcmpi("charge",type))
      printf("charge\n");      
      cData=struct2cell(data);
      #typeinfo(cData);
      #disp(cData);
      mData=cell2mat(cData);
      Voltage_measured=getfield(data,"Voltage_measured");
      Current_measured=getfield(data,"Current_measured");
      Temperature_measured=getfield(data,"Temperature_measured");
      Current_charge=getfield(data,"Current_charge");
      Voltage_charge=getfield(data,"Voltage_charge");
      Time=getfield(data,"Time");
      
      fid=fopen('myFile.csv','at');
      fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Voltage_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Voltage_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Current_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Current_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Temperature_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Temperature_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Current_charge");
      fclose(fid);
      dlmwrite("myFile.csv",Current_charge,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Voltage_charge");
      fclose(fid);
      dlmwrite("myFile.csv",Voltage_charge,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Time");
      fclose(fid);
      dlmwrite("myFile.csv",Time,"-append")
      #mData'
    elseif(strcmpi("discharge",type))
      printf("discharge\n");
      #cData=struct2cell(data);
      Voltage_measured=getfield(data,"Voltage_measured");
      Current_measured=getfield(data,"Current_measured");
      Temperature_measured=getfield(data,"Temperature_measured");
      Current_charge=getfield(data,"Current_load");
      Voltage_charge=getfield(data,"Voltage_load");
      Time=getfield(data,"Time");
      Capacity=getfield(data,"Capacity")
      
      fid=fopen('myFile.csv','at');
      fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Voltage_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Voltage_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Current_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Current_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Temperature_measured");
      fclose(fid);
      dlmwrite("myFile.csv",Temperature_measured,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Current_load");
      fclose(fid);
      dlmwrite("myFile.csv",Current_charge,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Voltage_load");
      fclose(fid);
      dlmwrite("myFile.csv",Voltage_charge,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Time");
      fclose(fid);
      dlmwrite("myFile.csv",Time,"-append")
      fid=fopen('myFile.csv','at');
        fprintf(fid,'%s,%d,%s,%s, ',type,temp,datestr(time),"Capacity")
      fclose(fid);
      dlmwrite("myFile.csv",Capacity,"-append")
      
      #disp(cData);
      #Making each cell of equal size
      #tmp=getfield(data,"Capacity");
      #cap=repmat(tmp,1,length(getfield(data,"Voltage_measured")));
      #cData(7,1)=cap;
      #mData=cell2mat(cData);
      #mData'      
      
    #elseif(strcmpi("impedance",type))
     else 
      printf("impedance\n");
      
      Sense_current=getfield(data,"Sense_current");
      Battery_current=getfield(data,"Battery_current");
      Current_ratio=getfield(data,"Current_ratio");
      Battery_impedance=getfield(data,"Battery_impedance");
      Rectified_Impedance=getfield(data,"Rectified_Impedance");
      Re=getfield(data,"Re");
      Rct=getfield(data,"Rct")
      
      fid=fopen('myFile.csv','at');
      fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Sense_current");
      fclose(fid);
      dlmwrite("myFile.csv",Sense_current,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Battery_current");
      fclose(fid);
      dlmwrite("myFile.csv",Battery_current,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Current_ratio");
      fclose(fid);
      dlmwrite("myFile.csv",Current_ratio,"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Battery_impedance");
      fclose(fid);
      dlmwrite("myFile.csv",Battery_impedance',"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Rectified_Impedance");
      fclose(fid);
      dlmwrite("myFile.csv",Rectified_Impedance',"-append")
      fid=fopen('myFile.csv','at');
       fprintf(fid,'%s,%d,%s,%s,',type,temp,datestr(time),"Re");
      fclose(fid);
      dlmwrite("myFile.csv",Re,"-append")
      fid=fopen('myFile.csv','at');
        fprintf(fid,'%s,%d,%s,%s, ',type,temp,datestr(time),"Rct")
      fclose(fid);
      dlmwrite("myFile.csv",Rct,"-append")
    endif
    
    
    fields=fieldnames(data);
    for i=1:numel(fields)
      #fields{i}
      tmp=getfield(data,fields{i});
      #disp(tmp);
    endfor
    #disp(data)
    
  endfor
endfunction


#displayStruct(dd)
load Resources/Battery/B0018.mat;
#displayStruct(B0005)
buildM(B0018.cycle);
#buildMatrix(B0005.cycle)