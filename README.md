# fooderlich

A flutter project to demonstrate navigation 2.

## Application Screen shot

![image](https://user-images.githubusercontent.com/20933055/235299305-a048bfd3-bae1-4d88-812e-1b2253c8bba1.png)
![image](https://user-images.githubusercontent.com/20933055/235299322-65a26ceb-9e77-491e-8120-7cb81db9018d.png)
![image](https://user-images.githubusercontent.com/20933055/235299342-ce576c24-abcb-4eaa-9c3e-1f05e6dff7e4.png)
![image](https://user-images.githubusercontent.com/20933055/235299363-8445eca3-cee8-468c-b2d9-2c8405a8df61.png)
![image](https://user-images.githubusercontent.com/20933055/235299517-29dc3b2a-7d15-4169-91ac-95f630175e7f.png)

## Go router
The Router API gives you more abstractions and control over your navigation stack. 
However, the API’s complexity and usability hindered the developer experience.
![image](https://user-images.githubusercontent.com/20933055/235299406-5b7dbe61-bb41-4934-85be-ffa0cebd2b17.png)
GoRouter aims 
to make it easier for developers to handle routing, letting them focus on building the 
best app they can.
In this application we’ll focus on how to:
• Create routes.
• Handle errors.
• Redirect to another route.
# A simple note
Note: There are two ways to navigate to different routes:
1.) context.go(path)
2.) context.goNamed(name)
You should use goNamed instead of go as it’s error-prone, and the actual URI 
format can change over time.
goNamed performs a case-insensitive lookup by using the name parameter you 
set with each GoRoute. goNamed also helps you pass in parameters and query 
parameters to your route.

https://user-images.githubusercontent.com/20933055/235299127-d70fb2c3-4f81-42ad-86b4-f1195639dfdc.mp4

