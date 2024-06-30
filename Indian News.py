#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import requests


# In[2]:


api_key="fdd3aefe-34bb-461e-b630-146be8f99bc6"


# In[3]:


api_url = "https://content.guardianapis.com/search"
page_link = "https://www.theguardian.com/india"


# In[4]:


article_id = page_link.split('/')[-1]

print(article_id)


# In[5]:


total_pages = 70


# In[6]:


ans=[]


# In[7]:


for current_page_number in range(1, total_pages + 1):
    params = {
        "q": article_id,
        "api-key": api_key,
        "page": current_page_number
    }
    
    response = requests.get(api_url, params=params)
    
    if response.status_code == 200:
        data = response.json()
        ans.append(data)
    else:
        print(f"Failed to retrieve page {current_page_number}")
        break  # Break the loop if there's an issue with the request


# In[8]:


ans


# In[9]:


urlList=[]


# In[10]:


for i in range(1,7254):
    a = "https://content.guardianapis.com/search?q=india&api-key=fdd3aefe-34bb-461e-b630-146be8f99bc6&page="
    b= str(i)
    c=a+b
    urlList.append(c)


# In[11]:


urlList


# In[12]:


len(ans)


# In[13]:


ans[0]['response']['results'][1]['webTitle']


# In[14]:


finalNews=[]


# In[15]:


for i in range(0,total_pages):
    for j in range(0,10):
        value = dict(
            webTitle = ans[i]['response']['results'][j]['webTitle'],
        sectionName = ans[i]['response']['results'][j]['sectionName'],
        publicationDate = ans[i]['response']['results'][j]['webPublicationDate']),
        finalNews.append(value)


# In[16]:


finalNews


# In[17]:


datanew = pd.DataFrame(finalNews)


# In[18]:


datanew


# In[ ]:



