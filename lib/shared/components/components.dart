import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
//import 'package:todo_app/modules/login/Login_Screen.dart';
//import 'package:todo_app/modules/web_view/web_view_screen.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepPurple,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      color: background,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget ButtonRegister({
  double width = double.infinity,
  Color background = Colors.deepPurple,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      color: background,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required Function validate,
  required IconData prefix,
  String hint = 'Email',
  bool isClickable = true,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: () {
        onTap!();
      },
      onFieldSubmitted: (String? value) {
        onSubmit!(value);
      },
      onChanged: (String? value) {
        onChange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );

Widget defaultFormFieldpass({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required Function validate,
  required IconData prefix,
  String hint = 'Password',
  IconData? suffix,
  IconData? suffixmark,
  bool ispass = false,
  Function? onSubmit,
  Function? onChange,
  Function? suffixpressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispass,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultFormFieldConfirmPass({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required Function validate,
  required IconData prefix,
  String hint = 'Confrm Password',
  IconData? suffix,
  IconData? suffixmark,
  bool isconfirmpass = false,
  Function? onSubmit,
  Function? onChange,
  Function? suffixpressed,
  Function? suffixmarkpressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isconfirmpass,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget FormFieldRegisterfname({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required Function validate,
  required IconData prefix,
  String hint = 'First Name',
  Function? onSubmit,
  Function? onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );

Widget FormFieldRegisterlname({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required Function validate,
  required IconData prefix,
  String hint = 'Last Name',
  Function? onSubmit,
  Function? onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            CircleAvatar(

              radius: 40.0,

              child: Text(

                '${model['time']}',

              ),

            ),

            const SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    '${model['title']}',

                    style: TextStyle(

                      fontSize: 18.0,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  Text(

                    '${model['date']}',

                    style: TextStyle(

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(

              width: 20.0,

            ),

            IconButton(

                onPressed:()

                {

                  AppCubit.get(context).updateData(

                    status:'done',

                    id:model['id'],

                  );

                },

                icon:Icon(

                  Icons.check_box,

                  color: Colors.green,

                ) ,

            ),

            IconButton(

              onPressed:()

              {

                AppCubit.get(context).updateData(

                  status:'archive',

                  id:model['id'],

                );

              },

              icon:Icon(

                Icons.archive,

                color: Colors.black54,

              ) ,

            ),

          ],

        ),

      ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(
        id:model['id'],
    );
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context,index) => buildTaskItem(tasks[index],context),
    separatorBuilder:(context,index) => myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 60.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet , Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Container(



  width: double.infinity,



  height: 1.0,



  color: Colors.grey[300],



);



void navigateTo(context , Widget) => Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),

);

// Widget buildArticleItem(article , context) => InkWell(
//   onTap: ()
//   {
//     navigateTo(context, WebViewScreen(article['url'],),
//     );
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(20.0),
//
//     child: Row(
//
//       children: [
//
//         Container(
//
//           width: 120.0,
//
//           height: 120.0,
//
//           decoration: BoxDecoration(
//
//             borderRadius: BorderRadius.circular(10.0,),
//
//             image: DecorationImage(
//
//               image: NetworkImage('${article['urlToImage']}',),
//
//               fit: BoxFit.cover,
//
//             ),
//
//           ),
//
//         ),
//
//         const SizedBox(
//
//           width: 20.0,
//
//         ),
//
//         Expanded(
//
//           child: Container(
//
//             height: 120.0,
//
//             child: Column(
//
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               crossAxisAlignment: CrossAxisAlignment.center,
//
//               children: [
//
//                 Expanded(
//
//                   child: Text(
//
//                     '${article['title']}',
//
//                     style: Theme.of(context).textTheme.bodyText1,
//
//                     maxLines: 3,
//
//                     overflow: TextOverflow.ellipsis,
//
//                   ),
//
//                 ),
//
//                 Text(
//
//                   '${article['publishedAt']}',
//
//                   style: TextStyle(
//
//                     color: Colors.grey,
//
//                   ),
//
//                 ),
//
//               ],
//
//             ),
//
//           ),
//
//         ),
//
//       ],
//
//     ),
//
//   ),
// );
//
// Widget articleBuilder(list , context , {isSearch = false}) => ConditionalBuilder(
//   condition: list.length > 0,
//   builder:(context) => Expanded(
//     child: ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       itemBuilder:(context , index) =>  buildArticleItem(list[index] , context),
//       separatorBuilder:(context , index) => myDivider(),
//       itemCount:list.length,
//     ),
//   ),
//   fallback:(context) => isSearch ? Container() : const  Center(
//     child: CircularProgressIndicator(
//     ),
//   ),
// );