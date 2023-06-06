/// Copyright (c) 2023 Noé Perard-Gayot
/// This work is licensed under the terms of the MIT license. For a copy see <https://opensource.org/licenses/MIT>

#include "random_map_script.h"

using namespace GDRMS;

void RandomMapScript::_bind_methods() {
    // BIND properties
    BIND_GDPROPERTY(RandomMapScript, String, name,          Variant::STRING);
    BIND_GDPROPERTY(RandomMapScript, String, description,   Variant::STRING);
}
