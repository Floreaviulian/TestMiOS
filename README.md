# General Information

Modify the given application to display a list of developers in a Table View with self sizing cells.

# Data Source

Use BDataProvider framework to obtain the information about the developers.

A developer has the fallowing properties:

![image1](/images/1.png)

Informations are provided by a TeamProvider witch implements TeamDataProviderDelegate protocol. Use TeamDataUpdaterDelegate protocol to update the UI when changes in data source appear.

![image2](/images/2.png)

# User interface

Every table cell will have an image view in the left. The aspect ration of the image view is 1:1. The width of the image view is 25% of the cell width. The image view is aligned 16 points to left margin and 16 points to top.

On the right we have 3 labels. First for the developer’s name, second for the address and third for coding level. The coding level label should be multi-line. Distance between the 3 labels is 8 points. The horizontal distance between the image view and labels is 16 points. First label is aligned 16 points to top.

On the bottom of the cell is displayed a button with “Show encryption key” title. The buttons is alined 8 points to bottom.

![image3](/images/3.png)

The image used will be downloaded from the URL provided in “photoURL” property. Use a circle view (not a circle image) as a placeholder for the image. Display a spinner while image is downloading.

![image4](/images/4.png)

When user taps on the “Show encryption key” button, the button will disappear and a label displaying the encryption key will appear on the left. A spinner will be displayed instead of the button, until the encryption key is generated.

![image5](/images/5.png)

The encryption key’s label is aligned 8 points to left margin and the distance between the image view and the label is 8 points.

![image6](/images/6.png)

After 5 seconds, you must hide the generated encryption key and show the “Show encryption key” button again. A new key should be generated every time user taps on the button.

