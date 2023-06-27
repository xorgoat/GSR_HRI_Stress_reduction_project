# GSR_HRI_Stress_reduction_project
Code used in the paper titled, "Effectiveness of Using Social Robots in Stress Reducing Interventions for University Students; Using Galvanic Skin Response to Measure Stress"


The repository includes the code used to extract the necessary data from surveys and GSR signals and the analysis of that data in R.

Guide to files
-

Python:
The following files all share a basic structure to score the surveys:
- 'ati_final'
- 'psq_final'
- 'utaut_final'
- 'utaut_subsection' 
'utaut_subsection' is likely the most different given the scoring was seperated by UTAUT sections. 
'preprocessing_final' preprocesses the GSR data.

R:
The R files with 'alt' in its name are from the first attempt and are obsolete. 
The second attempt files include: 
- 'ati_analysis'
- 'stress_measurements_analysis'
- 'utaut_section_analysis'
- 'utaut_stress_analysis'
The first three listed follow the same process and are thus fairly similar.

Choreographe
The robot behavior is uploaded as a choreographe file. Simply the behavior includes starting up Pepper, playing the video, and waving goodbye.
