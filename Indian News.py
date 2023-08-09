#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


import requests


# In[15]:


api_key="fdd3aefe-34bb-461e-b630-146be8f99bc6"


# In[34]:


api_url = "https://content.guardianapis.com/search"
page_link = "https://www.theguardian.com/india"


# In[35]:


article_id = page_link.split('/')[-1]


# In[49]:


params = {
    "q": article_id,  
    "api-key": api_key,     
    "page": current_page_number
}


# In[50]:


response = requests.get(api_url, params=params)
print(response)


# In[51]:


request = requests.Request('GET', api_url, params=params)


# In[52]:


data = response.json()
print(data)


# In[53]:


print(article_id)


# In[54]:


current_page_number = 1


# In[55]:


generated_url = request.prepare().url


# In[56]:


print(generated_url)


# In[72]:


urlList=[]
    


# In[73]:


for i in range(1,7254):
    a = "https://content.guardianapis.com/search?q=india&api-key=fdd3aefe-34bb-461e-b630-146be8f99bc6&page="
    b= str(i)
    c=a+b
    urlList.append(c)


# In[74]:


urlList


# In[83]:


fourUrls=[]


# In[86]:


info=[]


# In[84]:


for i in range(1,5):
    a = "https://content.guardianapis.com/search?q=india&api-key=fdd3aefe-34bb-461e-b630-146be8f99bc6&page="
    b= str(i)
    c=a+b
    fourUrls.append(c)


# In[94]:


fourUrls


# In[99]:


def json(url):
    response=requests.get(url).json()
    info.append(response)
    
    


# In[100]:


info=[]


# In[101]:


output = [json(url) for url in fourUrls]


# In[102]:


info


# In[91]:


len(info)


# In[111]:


finalList=[]


# In[112]:


for i in range(0,4):
    for j in range(0,10):
        values=dict(HeadLines=info[i]['response']['results'][j]['webTitle'],
        SectionName=info[i]['response']['results'][j]['sectionName'],
                   PublishDate=info[i]['response']['results'][j]['webPublicationDate'])
        finalList.append(values)


# In[113]:


finalList


# In[114]:


new_data = pd.DataFrame(finalList)


# In[115]:


new_data


# In[ ]:




