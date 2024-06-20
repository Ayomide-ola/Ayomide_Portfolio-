import plotly.express as px
import streamlit as st
import pandas as pd
from PIL import Image

# Data loading function
Author_sorted = pd.read_csv('Author_data.csv')
Age_sorted = pd.read_csv('Age_data.csv')

st.set_page_config(layout="centered")  # centered, wide

@st.cache(allow_output_mutation=True)
def author_age_based(title, Age_group, number):
    # Ensure input title exists in Author_sorted
    if title not in Author_sorted['Title'].values:
        return pd.DataFrame(columns=['Title', 'Author', 'weighted_average', 'Age_group'])
    
    # Fetch the author of the given title
    Author_df = Author_sorted.loc[Author_sorted['Title'] == title]['Author'].unique()[0]
    
    # Get books by the same author
    Author_by_title = Author_sorted[Author_sorted['Author'] == Author_df].sort_values(by='weighted_average', ascending=False)
    
    # Filter books based on Age_group
    Age_df = Age_sorted[Age_sorted['Age_group'] == Age_group]
    
    # Get books by authors in the specified Age_group
    title_by_age = Age_df[Age_df['Author'].isin(Author_by_title['Author'].unique())].sort_values(by='weighted_average', ascending=False)
    
    # Exclude the original title from the recommendations
    recommendations = title_by_age[title_by_age['Title'] != title]
    
    # Get top N recommendations
    top_recommendations = recommendations.head(number)
    
    # Ensure columns are returned as expected
    top_recommendations = top_recommendations[['Title', 'Author', 'weighted_average', 'Age_group']]
    
    return top_recommendations

# Load image
image = Image.open("Books_HD_(8314929977).jpg")
st.image(image, use_column_width=True)

# Instruction text
st.write('Welcome: Please fill in the details of the book in the left sidebar and click on the button below!')


# Defining the content of the sidebar
Book_title = Age_sorted['Title'].unique().tolist()
Age_Category = Age_sorted['Age_group'].unique().tolist()

# Setting the sidebars
Book_name = st.sidebar.selectbox("Select Title", Book_title)
Age_group = st.sidebar.selectbox("Your Age Group", Age_Category)
Number = st.sidebar.number_input("How many recommendations", min_value=1, max_value=10, step=1)

# Generate recommendations
if st.sidebar.button("Get Recommendations"):
    new_recommendation = author_age_based(Book_name, Age_group, Number)

    # Check if recommendations are available
    if not new_recommendation.empty:
        # Plot recommendations
        st.write('See the most ratings of these books:')
        fig = px.bar(new_recommendation, x='Title', y='weighted_average',
                     hover_data=['Author', 'Age_group'], color='weighted_average',
                     labels={'weighted_average': 'Weighted Average'}, height=400)
        fig.update_layout(
            title=(f"Top {Number} books recommended for '{Book_name}'"),
            xaxis_title=('Book Titles'),
            yaxis_title=('Weighted Average')
        )
        st.plotly_chart(fig)
    else:
        st.write("No recommendations found. Please try different inputs.")