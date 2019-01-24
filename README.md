# Brain-Tumor-Classification-for-MR-Images-using-Transfer-Learning-and-Fine-Tuning-
This code will run on a computer with GPU and MATLAB R2017b or later version
First download the CE-MRI Dataset to your computer.
Run Five_Fold_valid_MRI_Dataset.
install MATLAB toolbox for VGG19.
Run the main filee with name FT to train the model. These files are self explained and commented.
There are six models, the user should train each model on five fold data set.
After testing the model, the classification labels are saved to label.mat in current directory.
To check the classification performance metrics, run the set1_perf_Param.
user can edit the set1_perf_Param for others five fold testing sets.
