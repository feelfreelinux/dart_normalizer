import 'package:dart_normalizer/schema/polymorfic.dart';


var validateSchema = (definition) => definition[0];

var  getValues = (input) => (input is List) ? input : input.values;

 normalize4(schema, input, parent, key, visit, addEntity) {
   print("normalize4 $input");
  // validateSchema(schema);
var values = getValues(input);

if(!(values is List)){
return visit(values, parent, key, schema, addEntity);
}

// Special case: Arrays pass *their* parent on to their children, since there
// is not any special information that can be gathered from themselves directly
return values.map((value) => visit(value, parent, key, schema, addEntity)).toList();
}

denormalize (schema, input, unvisit)  {
schema = validateSchema(schema);
return input && input.map ? input.map((entityOrId) => unvisit(entityOrId, schema)) : input;
}

class ArraySchema extends PolymorphicSchema {
  ArraySchema(definition, schemaAttribute) : super(definition, schemaAttribute);


  normalize(input, parent, key, visit, addEntity) {
    final values = getValues(input);

    return values
        .map((value, index) => this.normalizeValue(value, parent, key, visit, addEntity))
        .where((value) => value !=null).toList();
  }

  denormalize(input, unvisit) {
    return input && input.map ? input.map((value) => this.denormalizeValue(value, unvisit)) : input;
  }
}