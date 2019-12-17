// Initialize the platform object:
var platform = new H.service.Platform({
    app_id: 'icDUzRIlkkoHxVh3ZWBc',
    app_code: 'xzPGxFrpDl1aStROU6d7jA'
    });

    // Obtain the default map types from the platform object
    var maptypes = platform.createDefaultLayers();

    // Instantiate (and display) a map object:
    var map = new H.Map(
    document.getElementById('mapContainer'),
    maptypes.normal.map,
    {
      zoom: 10,
      center: { lng: 13.4, lat: 52.51 }
    });

  var router = platform.getRoutingService(),
  routeRequestParams = {
    mode: 'fastest;car',
    representation: 'display',
    routeattributes: 'waypoints,summary,shape,legs',
    maneuverattributes: 'direction,action',
    waypoint0: '52.5160,13.3779', // Brandenburg Gate
    waypoint1: '52.5206,13.3862'  // Friedrichstraße Railway Station
  };


router.calculateRoute(
  routeRequestParams,
  onSuccess,
  onError
);