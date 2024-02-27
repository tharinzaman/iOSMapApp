This application utilizes MapKit in order to display hybrid locations on a screen. The user can choose to display either their own location, or a random location.
The latter will be fetched from a remote API using Swift's async await. There is also fully functional code to fetch it using Combine, however it is not in use as
the approach using async/await has been preferential for this specific application's needs. There are also alerts displayed for any missing permisisons/services
and also for any issues concerning networking.
