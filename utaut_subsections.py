import os
import pandas as pd


def utaut_scoring(dataframe,column_list):

    """
    dataframe: pandas dataframe
    column_list: specific participant numbersto score
    returns: nested dictionary with the utaut scores for each participant and each 
                subsection with the participant number as the key for the outer dictionary
                    and subsection name as the key for the inner dictionary
    

    Scores the utaut questionnaire by subsection and stores scores in nested dictionary
    """
    
    #########################################################################
    scoring_keys = {'Strongly disagree':1, 'Disagree':2, 
        'Neither agree nor disagree':3, 'Agree':4, 'Strongly agree':5}
    #to be used for questions numbered in 'reverse_list'
    scoring_key_reverse = {'Strongly disagree':5, 'Disagree':4, 
        'Neither agree nor disagree':3, 'Agree':2, 'Strongly agree':1}
    reverse_list = [23,24,25]
    block_dict = {"Effort Expectancy":[1,2,3,4,5],"Performance Expectancy":[6,7,8,9],"Perceived Enjoyment":[10,11,12],
        "Satisfaction":[13,14,15,16,17],"Trust":[18,19,20,21,22],"Perceived Risk":[23,24,25],"Behavioral Intention":[26,27,28]}

    #########################################################################

    score_dict = {}
    
    for i in column_list:
        subsection = {}
        df = dataframe[(dataframe[i]> 0.0)]['Degree']
        
        for keys, values in block_dict.items():
            score = 0
            question_number = 0
            
            for row_name in df:
                question_number+=1
                
                if question_number in values:
                    if keys == 6:
                        score += scoring_key_reverse[row_name]   
                    else:
                        score += scoring_keys[row_name]
                       
            subsection[keys] = score
        score_dict[i] = subsection

    return score_dict

###
                           
robot_list = [2, 6, 10, 13, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 43]
laptop_list = [3, 5, 7, 11, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44]

lists = [laptop_list,robot_list]

filename1 = "/Post Laptop Condition_csv_u8.csv"
filename2 = "/Post Robot Condition_csv_u8.csv"
files = [filename1,filename2]
names = ["Laptop","Robot"]
utaut_dict = {}

for i in range(len(files)):
    filepath = 'D:/Documents/S2Y3/Thesis/experiment/UTAUT'+ files[i]
    dataset = pd.read_csv(filepath, skiprows=2)
    df = pd.DataFrame(dataset)
    
    df = df.fillna(-1)
    col1 = df.loc[2,:]
    df=df.iloc[4:-1, 2:]
    
    df = df.rename(columns=col1)
    df = df.rename(columns={-1:'Degree'})

    score = utaut_scoring(df,lists[i])
    utaut_dict[names[i]] = score
    
    score_df = pd.DataFrame.from_dict(score, orient='index')
    score_df.to_csv(names[i]+"_utaut_subsection_score.csv")

