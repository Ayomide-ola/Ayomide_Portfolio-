import streamlit as st
import pandas as pd
from PIL import Image
import pickle
import plotly.graph_objs as go
import matplotlib.pyplot as plt
import shap

st.set_page_config(layout="centered")  # this configures the page to centre  

@st.cache(allow_output_mutation=True)
def load(data_path, model_path):
    data  = pickle.load(open(data_path, 'rb'))
    model = pickle.load(open(model_path, 'rb'))
    return data, model


def predict_and_explain_price(new_case, model):
    
    feat_cols = ['manufacturer_name', 'model_name', 'transmission', 'color',
       'engine_fuel', 'engine_has_gas', 'engine_type', 'body_type',
       'has_warranty', 'state', 'drivetrain', 'year_produced','odometer_value']
    
    case_to_predict = pd.DataFrame([new_case], columns = feat_cols)
    
    categoricals = ['manufacturer_name', 'model_name', 'transmission', 'color',
       'engine_fuel', 'engine_has_gas', 'engine_type', 'body_type',
       'has_warranty', 'state', 'drivetrain']
    
    for feature in categoricals:
        case_to_predict[feature] = pd.Series(case_to_predict[feature], dtype="category")
    
    prediction = round(model.predict(case_to_predict)[0], 2)
    predicted_price = 'The predicted price of your selection is **' + str(prediction) + '** $.'
        
    explainer = shap.TreeExplainer(model)
    shap_values = explainer.shap_values(case_to_predict)
    
    direction = 'up' if prediction > explainer.expected_value else 'down' # Sets the value of the variable direction to 'up' if the value of prediction is greater than explainer.expected_value; otherwise, it sets direction to 'down'.
    
    # Create a list with the Shap values for specific case
    original_sv = shap_values[0].tolist()
    sv = original_sv.copy()
    if direction == 'up':
        sv = [i for i in sv if i>0]
    else:
        sv = [i for i in sv if i<0]
        
    

    rev_sv = [abs(i) for i in sv].copy() # Get the absolute values of the list and reverse it. That way we see the "top" features
    rev_sv.sort(reverse=True) # sorts the list 'rev_sv' in place in descending order
    
    # Keep the top 4 shap values (contributions to the prediction) and find their positions in the original list
    max0 = rev_sv[0] if rev_sv[0] in sv else -rev_sv[0]
    max1 = rev_sv[1] if rev_sv[1] in sv else -rev_sv[1]
    max2 = rev_sv[2] if rev_sv[2] in sv else -rev_sv[2]
    max3 = rev_sv[3] if rev_sv[3] in sv else -rev_sv[3]
    print(max0, max1, max2, max3)
    
    max0_index = original_sv.index(max0)
    max1_index = original_sv.index(max1)
    max2_index = original_sv.index(max2)
    max3_index = original_sv.index(max3)
    print(max0_index, max1_index, max2_index, max3_index)
    
    # Identify the feature names and their values 
    feat0 = ' '.join(case_to_predict.columns[max0_index].split('_')).title()
    feat1 = ' '.join(case_to_predict.columns[max1_index].split('_')).title()
    feat2 = ' '.join(case_to_predict.columns[max2_index].split('_')).title()
    feat3 = ' '.join(case_to_predict.columns[max3_index].split('_')).title()
    
    val0 = case_to_predict.iloc[0,max0_index]
    val1 = case_to_predict.iloc[0,max1_index]
    val2 = case_to_predict.iloc[0,max2_index]
    val3 = case_to_predict.iloc[0,max3_index]
    
    explanation = 'The average price is ' + str(round(explainer.expected_value,2)) + '.' + '\n' + \
                  '\n' + 'The predicted price is driven **' + direction + '** mainly because:' + '\n' \
                  '\n' + '  a) **' + feat0 + '** is '  + str(val0) + ' and influenced the car price by **' + str(round(max0,2)) + '$**' + '\n' \
                  '\n' + '  b) **' + feat1 + '** is '  + str(val1) + ' and influenced the car price by **' + str(round(max1,2)) + '$**' + '\n' \
                  '\n' + '  c) **' + feat2 + '** is '  + str(val2) + ' and influenced the car price by **' + str(round(max2,2)) + '$**' + '\n' \
                  '\n' + '  d) **' + feat3 + '** is '  + str(val3) + ' and influenced the car price by **' + str(round(max3,2)) + '$**' + '\n' 
    
    fig = plt.figure(figsize=(10,7))
    shap.bar_plot(shap_values[0], case_to_predict, max_display=20)
    
    return predicted_price, explanation, fig

st.title('Car Price Prediction App')


#### Loading the saved objects

image = Image.open("car_photo.jpg")
data  = pd.read_pickle("dataset.pickle", compression=None)
model = pd.read_pickle("lgbm_cv.pickle",   compression=None)


st.image(image, use_column_width=True) # This sets the image on the dash

st.write('Hi, kindly fill in the details of your choice car in the left sidebar and click on the button below!') # This is an instructional promter under the car picture

# Define the contents of the sidebars... 

manufacturers = data['manufacturer_name'].unique().tolist() # This get the names of all the car manufacturers into a list
models = data.groupby('manufacturer_name')['model_name'].unique().apply(list).to_dict() #This get the names of all the car models from manufacturers into a list
transmission_type = data['transmission'].unique().tolist() # This puts car transmission into a list
colors = data['color'].unique().tolist() # This puts car colors into a list
fuels = data['engine_fuel'].unique().tolist() # This puts car engine fuel type into a list
engine_types = data['engine_type'].unique().tolist() # This puts car engine type into a list
body_types = data['body_type'].unique().tolist() # This puts car body type into a list
states = data['state'].unique().tolist() # This puts the state of the car into list 
drivetrains = data['drivetrain'].unique().tolist() # This puts the drivetrain into list. 

# It is important to put these datas into a list to ensure users can select from the available data in car dataset. This will show up as drop down menu when user uses the app. 
# No we can use 'sidebar' to set the lists we defined above into our dash. Selectbox makes it easy for users to select from available car data 
manufacturer_name = st.sidebar.selectbox("Manufacturer", manufacturers)
model_name = st.sidebar.selectbox("Model", models[manufacturer_name])
transmission = st.sidebar.selectbox("Type of transmission", transmission_type)
color =  st.sidebar.selectbox("Color", colors)
engine_fuel =  st.sidebar.selectbox("Engine fuel", fuels)
engine_type = st.sidebar.selectbox("Engine Type", engine_types)
body_type = st.sidebar.selectbox("Body Type", body_types)
state = st.sidebar.selectbox("State", states)
drivetrains = st.sidebar.selectbox("Drivetrain", drivetrains)
engine_has_gas = st.sidebar.radio("Engine has gas", [True, False])
warranty = st.sidebar.radio("Warranty", [True, False])
year_produced = st.sidebar.slider('Year Produced', 1950, 2019, 2015, 1)
odometer_value = st.sidebar.slider("Odometer value", 0, 1000000, 1000, 100)

# construct the new case for prediction
new_case = [manufacturer_name, model_name, transmission, color, engine_fuel, engine_has_gas, engine_type, body_type, warranty, state, drivetrains, year_produced, odometer_value]


#### Prediction and Boxplots to show the distribution 
if (st.button('Find Car Price')):
    
    ## Read the data, load the model, make the prediction and print it
    predicted_price, explanation, fig = predict_and_explain_price(new_case, model)
    st.subheader(predicted_price)
    
    st.write('----------------------------------------------------------------------------------------------------------------')

    st.subheader('Explain the prediction')
    st.write(explanation)
    st.write('The contribution of all parameters is the following (red when the parameter contributes positively to the predicted price, blue otherwise):', unsafe_allow_html=True)
    st.pyplot(fig)
    
    st.write('----------------------------------------------------------------------------------------------------------------')
    
    ## Boxplots for price distribution aimed at showing the range of price 
    st.write('See the price ranges per Manufacturer and Engine fuel:')
    fig = go.Figure()
    dropdown = []
    true_false = [False]*55
    cars = sorted(data['manufacturer_name'].unique())
    default = manufacturer_name
    
    for i, company in enumerate(cars):
        temp = data[data['manufacturer_name']==company][['engine_fuel','price_usd']]
        fig.add_trace(go.Box(x=temp['engine_fuel'], y=temp['price_usd'], name=company, visible=(company==default)))
        true_false2 = true_false.copy()
        true_false2[i] = True
        dropdown.append({'method':'update',
                          'label':company,
                          'args': [{"visible": true_false2}, 
                                  {"title": company}]
                        })
    
    updatemenus = [{'buttons':dropdown,
                    'direction':'down',
                    'showactive':False,
                    'active': cars.index(default)}]
    fig.update_layout(updatemenus=updatemenus, showlegend=True)
    st.plotly_chart(fig)
