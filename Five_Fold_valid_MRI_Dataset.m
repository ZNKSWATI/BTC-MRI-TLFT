clc;
clear all;
clear all;
close all;
% Download CE-MRI dataset available at (https://figshare.com/articles/brain_tumor_dataset/1512427). 
% Make a folder imageData and put all .mat file in it 
% Load five fold cross validation index file
load cvind5fold.mat
% Read the images data
for i = 1 : 3064
    % load image data from mat file and read image and label
    load(['C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\imageData\', num2str(i), '.mat']);
    oim=cjdata.image;
    imlab=cjdata.label;
% Apply normalization to images
    nim=minMaxNormalize(oim);
   % Save the image according to five fold set in respective tumor folder. After processing the whole dataset, take set1 as testing (testDS1) 
   %and remainig four sets as traing (trainingDS1). apply similar method for set2, set3, set4, and set5
    % Set1
    if cvind(i)==1   
	if imlab==1
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set1\meningioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	elseif imlab==2
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set1\glioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
   	elseif imlab==3
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set1\pituitary\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	else 
        fprintf('No label found');
    	end                  
    end
    
    % Set2
    if cvind(i)==2   
	if imlab==1
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set2\meningioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	elseif imlab==2
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set2\glioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
   	elseif imlab==3
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set2\pituitary\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	else 
        fprintf('No label found');
    	end          
    end
  
    % Set3
    if cvind(i)==3   
	if imlab==1
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set3\meningioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	elseif imlab==2
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set3\glioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
   	elseif imlab==3
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set3\pituitary\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	else 
        fprintf('No label found');
    	end             
    end
   
    % Set4
    if cvind(i)==4   
   
	if imlab==1
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set4\meningioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	elseif imlab==2
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set4\glioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
   	elseif imlab==3
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set4\pituitary\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	else 
        fprintf('No label found');
    	end         
    end
        
    % Set5
    if cvind(i)==5   
    
	if imlab==1
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set5\meningioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	elseif imlab==2
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set5\glioma\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
   	elseif imlab==3
        outputFileName = fullfile('C:\Users\Zar Nawab Khan Swati\Documents\MATLAB\MRI_Cancer_database\set5\pituitary\', [num2str(i) '.jpg']);
        imwrite(nim, outputFileName);
    	else 
        fprintf('No label found');
    	end   
    end    
end