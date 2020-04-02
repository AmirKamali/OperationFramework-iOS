# OperationFramework
Easy framework to perform configurable tasks in iOS



OperationFramework offers highly configurable way of executing ordered tasks in your iOS app. These tasks could include executing of multiple functions one after each other or displaying series of view controllers in the particular order.

UIOperationBuilder can be replaced instead of your navigation layer and handle navigating between screens. It also allow you to run your logic and skip certain view controllers when not necessary.


Some helpful scenarios that you can use Operation Framework:

- You want to display multiple screens to a user but the the order / visiblity of the screens will change depending of the user's input.

- You have multiple tasks in your app that use few screens.

- You want to execute series of background API calls one after each other every few minutes in your app to fetch your data.


Advantage of using operation framework.

- Clean coding
- Limiting scope of each task
- Easy editing 
- Easy swapping / adding / replacing behaviours
- Easy error handling
- Easy debugging


## How OperationFramework works ?


Operation framework is made from 4 main components:

- Operation Builder
- Chained Operation
- Operation Provider
- Operation Data Model

For more information and tutorial refer to the medium article

## More Information

for more information check out the [Medium Article ](https://medium.com/@amir.n3t/advanced-ios-app-developments-using-chained-operation-framework-cof-6edf5c066dba)

## License
[MIT](https://github.com/AmirKamali/OperationFramework-iOS/blob/master/LICENSE)


