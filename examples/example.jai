#import "Basic";
#import "String";
LDtkLoader :: #import, file "../module.jai";

main :: () {
    schema_str := "{\"jsonVersion\":\"\"}";

    if !LDtkLoader.load_ldtk_file(schema_str, "map.json") {
        print("Failed to load LDtk file\n");
        return;
    }

    LDtkLoader.import_map_data();

    mob := LDtkLoader.get_entity("Mob", LDtkLoader.state.file_detail.levels[0].uid);

    if mob.count > 0 {
        print("Entity Instances Size: %\n", mob.count);

        for entity: mob {
            print("----------------1---------------\n");
            print("Identifier: %\n", entity.identifier);
            print("X: %, Y: %\n", entity.x, entity.y);

            print("----------------2---------------\n");

            for fi: entity.fieldInstances {
                print("fieldInstance.identifier: %\n", fi.identifier);
                print("fieldInstance.type: %\n", fi.type);
                print("-------------------3-------------------\n");

                if equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_POINT) || equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_POINT) {
                    if fi.size > 0 {
                        print("Field Instance points Size: %\n", fi.points.count);
                        for pt: fi.points {
                            if pt.check != 1 break;
                            print("Point X: %, Y: %\n", pt.cx, pt.cy);
                        }
                    }
                    print("-------------------4-------------------\n");
                }

                if equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_INT) || equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_BOOL) {
                    if fi.size > 0 {
                        print("Field Instance Ints Size: %\n", fi.ints.count);
                        for iv: fi.ints {
                            if iv.check != 1 break;
                            print("Int Value: %\n", iv.intValue);
                        }
                    }
                    print("-------------------4-------------------\n");
                }

                if equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_COLOR) ||
                   equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_FILE_PATH) ||
                   (fi.type.count >= 9 && equal(slice(fi.type, 0, 9), LDtkLoader.LDTK_FIELD_TYPE_LOCAL_ENUM)) ||
                   equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_STRING) {
                    if fi.size > 0 {
                        for sv: fi.strings {
                            if sv.check != 1 break;
                            if sv.strValue {
                                print("String: %\n", sv.strValue);
                            }
                        }
                    }
                    print("-------------------5-------------------\n");
                }

                if equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_INTEGER) || equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_BOOL) {
                    if fi.size > 0 {
                        for iv: fi.ints {
                            if iv.check != 1 break;
                            print("Number: %\n", iv.intValue);
                        }
                    }
                    print("-------------------5-------------------\n");
                }

                if equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_FLOAT) || equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_FLOAT) {
                    if fi.size > 0 {
                        for fv: fi.floats {
                            if fv.check != 1 break;
                            print("Number: %\n", fv.floatValue);
                        }
                    }
                    print("-------------------5-------------------\n");
                }

                if (fi.type.count >= 15 && equal(slice(fi.type, 0, 15), LDtkLoader.LDTK_FIELD_TYPE_ARRAY_ENUM)) ||
                   equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_FILE) ||
                   equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_COLOR) ||
                   equal(fi.type, LDtkLoader.LDTK_FIELD_TYPE_ARRAY_STRING) {
                    if fi.size > 0 {
                        for sv: fi.strings {
                            if sv.check != 1 break;
                            if sv.strValue {
                                print("String: %\n", sv.strValue);
                            }
                        }
                    }
                    print("-------------------5-------------------\n");
                }
            }
        }
        print("-----------------------------------------------------------\n");
    }

    LDtkLoader.free_ldtk_data();
}
