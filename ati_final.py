import os
import pandas as pd


def ati_scoring(dataframe,column_list):

    """
    dataframe: pandas dataframe
    returns: dictionary with the utaut scores for each 
                participant with the participant number as the key

    Scores the ati questionnaire and stores score in dictionary
    """
    
    #########################################################################
    scoring_keys = {"Completely Disagree":1, "Largely Disagree":2, "Slightly Disagree":3, 
        "Slightly Agree":4, "Largely Agree":5, "Completely Agree":6}
    #to be used for questions numbered in 'reverse_list'
    scoring_key_reverse = {"Completely Disagree":6, "Largely Disagree":5, "Slightly Disagree":4, 
        "Slightly Agree":3, "Largely Agree":2, "Completely Agree":1}
    reverse_list = [3,6,8]
    #########################################################################

    score_dict = {}
    
    for i  in column_list: 
        score = 0
        df = dataframe[(dataframe[i]> 0.0)]['Degree']

        question_number = 0
        for row_name in df:
            question_number+=1
            if question_number not in reverse_list:
                #print("q n",question_number)
                #print(scoring_keys[row_name])
                score += scoring_keys[row_name]
            elif question_number in reverse_list:
                score += scoring_key_reverse[row_name]
        
        score_dict[i] = score

    return score_dict

                           
robot_list = [2, 6, 10, 13, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 43]
laptop_list = [3, 5, 7, 11, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44]

lists = [laptop_list,robot_list]
#rejects = [1,4,8,9,12,41]

filename1 = "/ati_csv.csv"
names = ["Laptop","Robot"]
ati_dict = {}

for i in range(len(names)):
    filepath = 'D:/Documents/S2Y3/Thesis/experiment/ATI'+ filename1
    dataset = pd.read_csv(filepath, skiprows=2)
    df = pd.DataFrame(dataset)

    df = df.fillna(-1)
    col1 = df.loc[2,:]
    df=df.iloc[4:-1, 2:]

    df = df.rename(columns=col1)
    df = df.rename(columns={-1:'Degree'})

    score = ati_scoring(df,lists[i])
    ati_dict[names[i]] = score

    score_df = pd.DataFrame.from_dict(score,orient='index')
    score_df.columns = ['Score']
    score_df.to_csv(names[i]+"_ati_score.csv")



ati_robot = pd.read_csv("Robot_ati_score.csv")
utaut_robot = pd.read_csv("Robot_utaut_score.csv")
ati_laptop = pd.read_csv("Laptop_ati_score.csv")
utaut_laptop = pd.read_csv("Laptop_utaut_score.csv")

ati_robot.columns = ['participant','score']
utaut_robot.columns = ['participant','score']
ati_laptop.columns = ['participant','score']
utaut_laptop.columns = ['participant','score']
laptop_merged = pd.merge(ati_laptop,utaut_laptop, on='participant', suffixes=["_ati","_utaut"])
#laptop_merged.columns = ['Participant','Pre','Post']

robot_merged = pd.merge(ati_robot,utaut_robot, on='participant', suffixes=["_ati","_utaut"])
#robot_merged.columns = ['Participant','Pre','Post']

print(robot_merged)


laptop_merged.to_csv("laptop_ati_utaut_scores.csv")
robot_merged.to_csv("robot_ati_utaut_scores.csv")

