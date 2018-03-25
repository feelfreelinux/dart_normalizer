import 'package:dart_normalizer/schema/polymorfic.dart';


var validateSchema = (definition) => definition[0];

var  getValues = (input) => (input is List) ? input : input.keys.map((item) =>input[item]);

 normalize(schema, input, parent, key, visit, addEntity) {
   schema = validateSchema(schema);
var values = getValues(input);
// Special case: Arrays pass *their* parent on to their children, since there
// is not any special information that can be gathered from themselves directly
return values.map((value) => visit(value, parent, key, schema, addEntity)).toList();
}

 denormalize(schema, input, unvisit) {
    schema = validateSchema(schema);
    return input != null && input is Iterable ? input.map((entityOrId) => unvisit(entityOrId, schema)) : input;
}


class ArraySchema extends PolymorphicSchema {
  ArraySchema(definition, {schemaAttribute}) : super(definition, schemaAttribute);

  normalize(input, parent, key, visit, addEntity) {
    final values = getValues(input);
    var list = values
        .map((value) => this.normalizeValue(value, parent, key, visit, addEntity))
        .where((value) => value !=null).toList();
    print("list $list");
    return list;
  }

  denormalize(input, unvisit) {
    return input !=null && input is Iterable ? input.map((value) => this.denormalizeValue(value, unvisit)) : input;
  }
}




