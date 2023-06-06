/// Copyright (c) 2023 Noé Perard-Gayot
/// This work is licensed under the terms of the MIT license. For a copy see <https://opensource.org/licenses/MIT>

#ifndef GDRMS_SCRIPT_H
#define GDRMS_SCRIPT_H

#include "macros.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/resource.hpp>



using namespace godot;

namespace GDRMS {

    class RandomMapScript : public Resource {
        GDCLASS(RandomMapScript, Resource);

    public:

        static void _bind_methods();

        GDPROPERTY(String, name);
        GDPROPERTY(String, description);

    };
};

#endif /* GDRMS_SCRIPT_H */
