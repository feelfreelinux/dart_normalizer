import 'package:dart_normalizer/schema/entity.dart';
import 'package:dart_normalizer/schema/immutable_utils.dart';


normalize1(schema, input, parent, key, visit, addEntity) {
  Map<dynamic, dynamic> object = {};
  object.addAll(input);
  (schema.keys).forEach((key) {
    var localSchema = schema[key];
     if(input[key]!= null) { //todo #hack need to check
    var value = visit(input[key], input, key, localSchema, addEntity);
    if (value == null) {
      object.remove(key);
    } else {
      object[key] = value;
    }
     }
  });
  return object;
}

denormalize1(schema, input, unvisit) {
 // return denormalizeImmutable(schema, input, unvisit);

  Map object = {};
  object.addAll(input);
  (schema.keys).forEach((key) {
    if (object[key] != null) {
      object[key] = unvisit(object[key], schema[key]);
    }
  });
  return object;
}




class ObjectSchema {
  Map schema = {};

  ObjectSchema(definition) {
    this.define(definition);
  }

  define(Map definition) {
    if (definition != null) {
      this.schema.addAll({});
      this.schema.addAll(definition);/*.map((key, value) {
        final schema = definition[key];
        return MapEntry(key, schema);
      });*/
    }
    if (schema == null) {
      this.schema = {};
    }
  }


  normalize(input, parent, key, visit, addEntity) {
    return normalize1(this.schema, input, parent, key, visit, addEntity);
  }

  denormalize( input, unvisit){
    print("denormalize2");
    return denormalize1(schema, input, unvisit);
  }

}