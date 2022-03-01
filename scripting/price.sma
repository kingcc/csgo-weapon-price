/**
 * CS:GO Weapon Price
 *
 * This plugin is dedicated to changing the weapons prices of CS1.6 to CS:GO.
 */

#include <amxmodx>
#include <amxmisc>
#include <orpheu_memory>

enum _:WeaponStructure ( += 4 )
{
    weaponID = 0,
    weaponCost,
    ammoCost,
    maxClip1,
    maxClip2,
    maxBpAmmo,
    weaponWeight,
    dummyData
}

new const prices[] = {
    0,

    300,    // p228
    0,
    200,    // glock
    1700,   // scout
    2000,   // xm1014

    1050,   // mac10
    3300,   // aug
    800,    // elites
    500,    // fiveseven
    1200,   // ump45

    5000,   // sg550
    1800,   // galil
    2050,   // famas
    200,    // usp
    0,      // awp

    1700,   // mp5
    5200,   // m249
    1200,   // m3
    0,      // m4a1
    0,      // tmp

    0,      // g3sg1
    700,    // deagle
    3000,   // sg552
    2700,   // ak47
    0,      // p90
}

public plugin_init ()
{
    register_plugin( "CS:GO Weapon Price", "1.0.0", "kingcc" )

    for (new i = 0; i < sizeof prices; i++)
    {
        if (prices[i] == 0) continue

        modify_price(i, weaponCost, prices[i])
    }
}

modify_price (const weapon_index, const type, const value)
{
    if (!max(0, value)) return

    #define get_offset(%0,%1) (WeaponStructure * (%0 - 1) + %1)

    new point
    OrpheuMemoryGet("weaponStruct", point)
    
    point += get_offset(weapon_index, type)
    OrpheuMemorySetAtAddress(point, "cost", 1, value)
}
