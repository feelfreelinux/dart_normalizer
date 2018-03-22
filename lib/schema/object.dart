import 'package:dart_normalizer/schema/entity.dart';


normalize1(schema, input, parent, key, visit, addEntity) {
  Map<dynamic, dynamic> object ={};
  object.addAll(input);
  (schema.keys).forEach((key) {
    var localSchema = schema[key];
    var value = visit(input[key], input, key, localSchema, addEntity);
    if (value == null) {
      object.remove(key);
    } else {
      object.remove(key);
      object[key] = value;
    }
  });
  return object;
}




class ObjectSchema {
  var schema;

  ObjectSchema(definition) {
    this.define(definition);
  }

  define(Map definition) {
    print("object schema ${definition.keys}");
    if(definition.length == 1 ) {
      var key = definition.keys.first;
      this.schema = {"entirySchema":{}, key :definition[key] };
    } else {
      this.schema=(definition.keys).reduce((entitySchema, key) {
        var schema = definition[key];
        return { "entirySchema": entitySchema, key: schema};
      }); }

  }


  normalize( input, parent, key, visit, addEntity) {
    return normalize1(this.schema, input, parent, key, visit, addEntity);
  }


}