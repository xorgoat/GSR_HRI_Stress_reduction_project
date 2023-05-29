import os
import pandas as pd


def psq_scoring(dataframe):

    """
    dataframe: pandas dataframe
    returns: dictionary with the stress scores for each 
                participant with the participant number as the key

    Scores the percieved stress questionnaire and stores score in dictionary
    """

    scoring_keys = {'Strongly disagree':1, 'Disagree':2, 
        'Neither agree nor disagree':3, 'Agree':4, 'Strongly Agree':5}
    #to be used for questions numbered in 'reverse_list'
    scoring_key_reverse = {'Strongly disagree':5, 'Disagree':4, 
        'Neither agree nor disagree':3, 'Agree':2, 'Strongly Agree':1}
    reverse_list = [1,7,10,13,17,21,25,29]
   
    score_dict = {}
    
    for i  in range(1,len(dataframe.columns)-1): 
        score = 0
        df = dataframe[(dataframe[i]> 0.0)]['Degree']

        question_number = 0
        for row_name in df:
            question_number+=1
            if question_number not in reverse_list:
                score += scoring_keys[row_name]
            elif question_number in reverse_list:
                score += scoring_key_reverse[row_name]
        
        score_dict[i] = score

    return score_dict



robot_list = [2, 6, 10, 13, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 43]
laptop_list = [3, 5, 7, 11, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44]
#rejects = [1,4,8,9,12,40]

filename1 = "\Crosstab-Pre Stress Management-Final-csv-utf8.csv"
filename2 = "\Crosstab-Post Stress Management-Final-csv-utf8.csv"
files = [filename1,filename2]
names = ["Pre","Post"]
psq_dict = {}

for i in range(len(files)):
    filepath = 'D:\Documents\S2Y3\Thesis\experiment\Survey Data'+ files[i]
    dataset = pd.read_csv(filepath, skiprows=2)
    df = pd.DataFrame(dataset)
    df = df.fillna(0)
    col1 = df.loc[2,:]
    df=df.iloc[4:-1, 2:]

    df = df.rename(columns=col1)
    df = df.rename(columns={0:'Degree'})

    score = psq_scoring(df)
    #psq_dict[names[i]] = score

    #get rid of excess values
    rl_dict = {}
    robot_dict = {}
    laptop_dict = {}
    for key, values in score.items():
        if key in robot_list:
           robot_dict[key]=values
        if key in laptop_list:
           laptop_dict[key]=values
    psq_df_robot = pd.DataFrame.from_dict(robot_dict,orient='index')
    psq_df_laptop = pd.DataFrame.from_dict(laptop_dict,orient='index')
    psq_df_robot.to_csv("robot_psq_score_"+names[i]+"_relax.csv")
    psq_df_laptop.to_csv("laptop_psq_score_"+names[i]+"_relax.csv")
    rl_dict["Robot"] = robot_dict
    rl_dict["Laptop"] = laptop_dict
    psq_dict[names[i]] = rl_dict


l_pre_df = pd.read_csv("laptop_psq_score_Pre_relax.csv")
l_post_df = pd.read_csv("laptop_psq_score_Post_relax.csv")
laptop_merged = pd.merge(l_pre_df,l_post_df, on='Unnamed: 0', suffixes=["_pre","_post"])
laptop_merged.columns = ['Participant','Pre','Post']

r_pre_df = pd.read_csv("robot_psq_score_Pre_relax.csv")
r_post_df = pd.read_csv("robot_psq_score_Post_relax.csv")
robot_merged = pd.merge(r_pre_df,r_post_df, on='Unnamed: 0', suffixes=["_pre","_post"])
robot_merged.columns = ['Participant','Pre','Post']

laptop_merged.to_csv("laptop_psq_score.csv")
robot_merged.to_csv("robot_psq_score.csv")