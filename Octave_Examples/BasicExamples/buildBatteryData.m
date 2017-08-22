clear all;
function cycleMatrix = buildMatrix(x,cycle,filepath)
    type=getfield(x,"type");
    temp=getfield(x,"ambient_temperature");
    time=getfield(x,"time");
    data=getfield(x,"data");
    
    if(strcmpi("charge",type))
      cData=struct2cell(data);
      mData=cell2mat(cData);
      [rows,cols] = size(mData);
      cycle=repmat(cycle,1,cols);
      type=repmat(1,1,cols);
      temp=repmat(temp,1,cols);
      #time=repmat(datestr(time),1,cols)
      
      m = [cycle;type;temp;mData];
      cycleMatrix = m';
    dlmwrite(filepath,cycleMatrix,'delimiter',',','-append');
    elseif(strcmpi("discharge",type))
      cData=struct2cell(data);
      tmp=getfield(data,"Capacity");
      cap=repmat(tmp,1,length(getfield(data,"Voltage_measured")));
      cData(7,1)=cap;
      mData=cell2mat(cData);
      [rows,cols] = size(mData);
      cycle=repmat(cycle,1,cols);
      type=repmat(2,1,cols);
      temp=repmat(temp,1,cols);
      time=repmat(datestr(time),1,cols);
      m = [cycle;type;temp;mData];
      cycleMatrix = m';
      dlmwrite(filepath,cycleMatrix,'delimiter',',','-append');
#    else
#    
#    Sense_current=getfield(data,"Sense_current");
#    Battery_current=getfield(data,"Battery_current");
#    Current_ratio=getfield(data,"Current_ratio");
#    Battery_impedance=getfield(data,"Battery_impedance");
#    Rectified_Impedance=getfield(data,"Rectified_Impedance");
#    Re=getfield(data,"Re");
#    Rct=getfield(data,"Rct")
#    [rows,cols] = size(Battery_current);
#    cycle=repmat(cycle,1,cols);
#    type=repmat(3,1,cols);
#    temp=repmat(temp,1,cols);
#    for i=length(Rectified_Impedance)+1:cols
#      Rectified_Impedance(i,1) = 99999;
#    endfor
#    Rct=repmat(Rct,cols,1);
#    Re=repmat(Re,cols,1);
#    mData=[Sense_current;Battery_current;Current_ratio;Battery_impedance';Rectified_Impedance';Re';Rct'];
#    
#    
#    m = [cycle;type;temp;mData];
#     cycleMatrix = m';
#     
#    for i=1:cols
#      tmp = sprintf('%s\n%s,%s,%s,%s,%s,%s,%s,%s,%s,%s',tmp,num2str(cycle'(i,1)),num2str(type'(i,1)),num2str(temp'(i,1)),num2str(Sense_current'(i,1)),num2str(Battery_current'(i,1)),num2str(Current_ratio'(i,1)),num2str(Battery_impedance(i,1)),num2str(Rectified_Impedance(i,1)),num2str(Rct(i,1)),num2str(Re(i,1)));
#   #fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',num2str(cycle'(i,1)),num2str(type'(i,1)),num2str(temp'(i,1)),num2str(Sense_current'(i,1)),num2str(Battery_current'(i,1)),num2str(Current_ratio'(i,1)),num2str(Battery_impedance(i,1)),num2str(Rectified_Impedance(i,1)),num2str(Rct(i,1)),num2str(Re(i,1)));
#    endfor
#    #fclose(fid);
#
#    #dlmwrite('impedance.csv',cycleMatrix,'delimiter',',','-append');
#    #dlmwrite("impedance.csv",[cycle' type' temp' Sense_current' Battery_current' Current_ratio' Battery_impedance Rectified_Impedance Rct Re ])
#     #cData=struct2cell(data);
#     cycleMatrix=0;
    endif
    
    
endfunction
function impedanceMatrix = buildImpedance(x,cycle)
      type=getfield(x,"type");
      temp=getfield(x,"ambient_temperature");
      time=getfield(x,"time");
      data=getfield(x,"data");
      Sense_current=getfield(data,"Sense_current");
      Battery_current=getfield(data,"Battery_current");
      Current_ratio=getfield(data,"Current_ratio");
      Battery_impedance=getfield(data,"Battery_impedance");
      Rectified_Impedance=getfield(data,"Rectified_Impedance");
      Re=getfield(data,"Re");
      Rct=getfield(data,"Rct");
      cycle = num2str(cycle);
      fid=fopen('impedance.csv','at');
      fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Sense_current");
      fclose(fid);
      dlmwrite("impedance.csv",Sense_current,"-append");
      fid=fopen('impedance.csv','at');
       fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Battery_current");
      fclose(fid);
      dlmwrite("impedance.csv",Battery_current,"-append");
      fid=fopen('impedance.csv','at');
       fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Current_ratio");
      fclose(fid);
      dlmwrite("impedance.csv",Current_ratio,"-append");
      fid=fopen('impedance.csv','at');
       fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Battery_impedance");
      fclose(fid);
      dlmwrite("impedance.csv",Battery_impedance',"-append");
      fid=fopen('impedance.csv','at');
       fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Rectified_Impedance");
      fclose(fid);
      dlmwrite("impedance.csv",Rectified_Impedance',"-append");
      fid=fopen('impedance.csv','at');
       fprintf(fid,'%s,%s,%d,%s,%s,',type,cycle,temp,datestr(time),"Re");
      fclose(fid);
      dlmwrite("impedance.csv",Re,"-append");
      fid=fopen('impedance.csv','at');
        fprintf(fid,'%s,%s,%d,%s,%s, ',type,cycle,temp,datestr(time),"Rct");
      fclose(fid);
      dlmwrite("impedance.csv",Rct,"-append");
endfunction

function buildImpedanceRaw(x,cycle)
    type=getfield(x,"type");
      temp=getfield(x,"ambient_temperature");
      time=getfield(x,"time");
      data=getfield(x,"data");
      Sense_current=getfield(data,"Sense_current");
      Battery_current=getfield(data,"Battery_current");
      Current_ratio=getfield(data,"Current_ratio");
      Battery_impedance=getfield(data,"Battery_impedance");
      Rectified_Impedance=getfield(data,"Rectified_Impedance");
      Re=getfield(data,"Re");
      Rct=getfield(data,"Rct");
      [rows,cols] = size(Battery_current);
    cycle=repmat(cycle,1,cols);
    type=repmat(3,1,cols);
    temp=repmat(temp,1,cols);
    for i=length(Rectified_Impedance)+1:cols
      Rectified_Impedance(i,1) = 99999;
    endfor
    Rct=repmat(Rct,cols,1);
    Re=repmat(Re,cols,1);
    dlmwrite("imp.csv",[cycle' type' temp' Sense_current' Battery_current' Current_ratio' Battery_impedance Rectified_Impedance Rct Re ],"-append");
endfunction

function writeToCSV(x)
  bat = 'B0018';
  chargeFile = strcat(bat,"charge.csv");
  dischargeFile = strcat(bat,"discharge.csv");
  fid=fopen(chargeFile,'w');
  fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s\n',"cycle","type","temperature","Voltage_measured","Current_measured","Temperature_measured","Current_charge","Voltage_charge","Time");
  fclose(fid);
  fid=fopen(dischargeFile,'w');
  fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',"cycle","type","temperature","Voltage_measured","Current_measured","Temperature_measured","Current_load","Voltage_load","Time","Capacity");
  #fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',"cycle","type","temperature","f1","f2","f3","f4","f5","f6","f7");
  fclose(fid);
  fid=fopen('imp.csv','w');
   fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',"cycle","type","temperature","Sense_current","Battery_current","Current_ratio","Battery_impedance","Rectified_impedance","Re","Rct");
  fclose(fid);
  fid=fopen('impedance.csv','w');
  fprintf(fid,'%s,%s,%s,%s,%s,%s\n',"type","cycle","temperature","startTime","fieldname","data");
  fclose(fid);
  for p=1:length(x)
   type=getfield(x(p),"type");
    if(strcmpi("impedance",type))
   
      buildImpedanceRaw(x(p),p);
    
     elseif(strcmpi("charge",type))
      m = buildMatrix(x(p),p,chargeFile);
     elseif(strcmpi("discharge",type))
      m = buildMatrix(x(p),p,dischargeFile);
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


load Resources/Battery/B0018.mat;

#buildM(B0005.cycle);
writeToCSV(B0018.cycle);