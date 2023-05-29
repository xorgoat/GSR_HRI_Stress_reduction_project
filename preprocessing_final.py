from pyEDA.main import *
import os
import glob
import pandas as pd
import csv
import numpy as np
import json

def mass_list_average(eda_list):
    """
    eda_list: a list of a the cleaned eda
    
    return: the average of the list

    The data is nshould be cleaned first
    """
    total_sum = 0
    for number in eda_list[0]:
        if type(number) != float or type(number) != int:
            try:
                print(number)
                number = float(number)
            except:
                continue
        
        total_sum += number
    

    return total_sum/len(eda_list)

    #intentional_error
#pls, this doesn't need to be ran again

robot_list = [2, 6, 10, 13, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 43]
laptop_list = [3, 5, 7, 11, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44]
session_names = {1:'Base', 2:'Stress', 3:'Relax'}
###
root_dir = 'D:\Documents\S2Y3\Thesis\experiment\experiment_data'

r_dict_TA_c = {}
r_dict_TA_r = {}

r_dict_IA_c = {}
r_dict_IA_r = {}

l_dict_TA_c = {}
l_dict_TA_r = {}

l_dict_IA_c = {}
l_dict_IA_r = {}

for folder in glob.iglob(root_dir + '**/*', recursive=True):
    p_dict_TA_c = {}
    p_dict_TA_r = {}
    p_dict_IA_c = {}
    p_dict_IA_r = {}
    counter = 0
    for filename in glob.iglob(folder + '**/*.csv', recursive=True):
        counter+=1
        dataset = pd.read_csv(filename,skiprows=1, delimiter=',')

        df = pd.DataFrame(dataset)
        df.iloc[:, 1:]
        cols = [2,3]
        df = df[df.columns[cols]]

        conductance = df[df.columns[0]]
        c = np.array(conductance[1:])
        resistance = df[df.columns[1]]
        r = np.array(resistance[1:])
        
        m_c, wd_c, eda_clean_c = process_statistical(c, use_scipy=True, sample_rate=250, new_sample_rate=40, segment_width=10, segment_overlap=0)
        m_r, wd_r, eda_clean_r = process_statistical(r, use_scipy=True, sample_rate=250, new_sample_rate=40, segment_width=10, segment_overlap=0)

        p_dict_TA_c[session_names[counter]] = mass_list_average(eda_clean_c)
        p_dict_TA_r[session_names[counter]] = mass_list_average(eda_clean_r)

        p_dict_IA_c[session_names[counter]] = m_c['mean_gsr']
        p_dict_IA_r[session_names[counter]] = m_r['mean_gsr']

    try: 
        participant_number = int(folder[-2:])
        print("Loading ", participant_number)
        if participant_number in robot_list:
            r_dict_TA_c[participant_number] = p_dict_TA_c
            r_dict_TA_r[participant_number] = p_dict_TA_r

            r_dict_IA_c[participant_number] = p_dict_IA_c
            r_dict_IA_r[participant_number] = p_dict_IA_r
        elif participant_number in laptop_list:
            l_dict_TA_c[participant_number] = p_dict_TA_c
            l_dict_TA_r[participant_number] = p_dict_TA_r

            l_dict_IA_c[participant_number] = p_dict_IA_c
            l_dict_IA_r[participant_number] = p_dict_IA_r
    except:
        print("Error with:",int(folder[-2:]))

    print(p_dict_IA_r)

#took a minute and a half

#list of dictionary names:
titanic_dict = {"Robot Conductance Total Avg":r_dict_TA_c, "Robot Resistance Total Avg":r_dict_TA_r, "Robot Conductance Intervals Avg":r_dict_IA_c, "Robot Resistance Intervals Avg":r_dict_IA_r, "Laptop Conductance Total Avg":l_dict_TA_c, "Laptop Resistance Total Avg":l_dict_TA_r, "Laptop Conductance Intervals Avg":l_dict_IA_c, "Laptop Resistance Intervals Avg":l_dict_IA_r}

#print(titanic_dict["Laptop Resistance Intervals Avg"])

with open("GSR_Data_Dictionary.json", "w") as fp:
        json.dump(titanic_dict, fp)

