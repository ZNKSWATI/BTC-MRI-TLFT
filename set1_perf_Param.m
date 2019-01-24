
clc
clear all;
close all;

load ('labels');
py=labels;
prdl=[];
x1=find(py=='glioma');
prdl(x1)=1;
x2=find(py=='meningioma');
prdl(x2)=2;
x3=find(py=='pituitary');
prdl(x3)=3;

T_P=0; T_N=0; F_N=0; F_P=0;

im_labels(1:264)=1; im_labels(265:407)=2; im_labels(408:570)=3;

y=prdl;
 Result=find(y==im_labels);
    Total_correct=size(Result,2);
    CL=(Total_correct/570)*100;
    
   c1=find(y(1:264)==1);
   Total_C1=size(c1,2);
   Cl1=(Total_C1/264)*100;
   
   c2=find(y(265:407)==2);
   Total_C2=size(c2,2);
   Cl2=(Total_C2/143)*100;
   
   c3=find(y(408:570)==3);
   Total_C3=size(c3,2);
   Cl3=(Total_C3/163)*100;
%Class 1
for i=1:570
    if(i<=264)
        if(y(i)==1)
            T_P=T_P+1;
        else
            F_N=F_N+1;
        end
    elseif(i>264 && i<=407)
            if(y(i)==2)
                T_N=T_N+1;
            else
                F_P=F_P+1;
            end
    elseif(i>407 && i<=570)
            if(y(i)==3)
                T_N=T_N+1;
            else
                F_P=F_P+1; 
            end
    end
end
TPRC1=T_P/(T_P+F_N)*100;
TNRC1=T_N/(T_N+F_P)*100;
PPRC1=T_P/(T_P+F_P)*100;
F1_C1=2*(TPRC1*PPRC1)/(TPRC1+PPRC1);
% 2*(Recall * Precision) / (Recall + Precision)
%Class 2
T_P=0; T_N=0; F_N=0; F_P=0;   
 for i=1:570
    if(i<=264)
        if(y(i)==1)
            T_N=T_N+1;
        else
            F_P=F_P+1;
        end
    elseif(i>264 && i<=407)
            if(y(i)==2)
                T_P=T_P+1;
            else
                F_N=F_N+1;
            end
    elseif(i>407 && i<=570)
            if(y(i)==3)
                T_N=T_N+1;
            else
                F_P=F_P+1;               
            end
    end
 end

TPRC2=T_P/(T_P+F_N)*100;
TNRC2=T_N/(T_N+F_P)*100;
PPRC2=T_P/(T_P+F_P)*100;
F1_C2=2*(TPRC2*PPRC2)/(TPRC2+PPRC2);
%Class 3      
T_P=0; T_N=0; F_N=0; F_P=0;    
   for i=1:570
    if(i<=264)
        if(y(i)==1)
            T_N=T_N+1;
        else
            F_P=F_P+1;
        end
    elseif(i>264 && i<=407)
            if(y(i)==2)
                T_N=T_N+1;
            else
                F_P=F_P+1;     
            end
    elseif(i>407 && i<=570)
            if(y(i)==3)
                T_P=T_P+1;
            else
                F_N=F_N+1;
            end
    end
end

TPRC3=T_P/(T_P+F_N)*100;
TNRC3=T_N/(T_N+F_P)*100;
PPRC3=T_P/(T_P+F_P)*100;
F1_C3=2*(TPRC3*PPRC3)/(TPRC3+PPRC3);

    Total_sen=TPRC1+TPRC2+TPRC3;
    Total_spe=TNRC1+TNRC2+TNRC3;
    Total_F1=F1_C1+F1_C2+F1_C3;
              
    TPRC=(Total_sen/3);
    TNRC=(Total_spe/3);
    PPRC=(PPRC1+PPRC2+PPRC3)/3;
    F1_C=(Total_F1/3);
 