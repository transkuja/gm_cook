{
  "$GMObject":"",
  "%Name":"obj_fridge",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":12,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_fridge",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"","%Name":"","name":"","objectId":{"name":"obj_par_spawner","path":"objects/obj_par_spawner/obj_par_spawner.yy",},"propertyId":{"name":"to_spawn","path":"objects/obj_par_spawner/obj_par_spawner.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"obj_par_item",},
  ],
  "parent":{
    "name":"Objects",
    "path":"folders/Objects.yy",
  },
  "parentObjectId":{
    "name":"obj_par_interactible",
    "path":"objects/obj_par_interactible/obj_par_interactible.yy",
  },
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"","%Name":"spawn_radius","filters":[],"listItems":[],"multiselect":false,"name":"spawn_radius","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"250","varType":0,},
    {"$GMObjectProperty":"","%Name":"snd_item_arrived","filters":[
        "GMSound",
      ],"listItems":[],"multiselect":false,"name":"snd_item_arrived","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"Click_01","varType":5,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"Fridge_192x400px",
    "path":"sprites/Fridge_192x400px/Fridge_192x400px.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}