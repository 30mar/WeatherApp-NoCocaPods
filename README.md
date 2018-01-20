# WeatherApp-NoCocaPods

Some Remarks:there is a bug in the weather api:

1-using the my current coordnates which are: latitude = 30.0033909967449 and longtude: 31.413896782353
the api returns right temp,icon,country but it returns an invalid city name, instead of "Cairo" the result is "testing", 
but all the other results are right.
I tried the above coordinates on geolaction sites and the result was cairo,
I tried different custom coordinates on the api nad the result is valid "giza , bany sweef, etc"
so i guess it is a bug in the api or something check different corrdinates and your will see what I meen.

2-The facebook api took most of the task time because facebook sharing was removed from ios 11 and i had to use the sdk 
and read thedocumentation which was  in objective c and very old "made for ios 9 syntax" but however it worked eventually but i
didn't have time to implement the twitter sharing.

3- in landscape the view was very crowded with all the labels, i fixed it but i had to decrease the fonts too much
and the app looked bad,so i disabled landscape mode for the app in order to keep it visually better.
