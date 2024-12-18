/// @description Insert description here
// You can write your code in this editor
if (directory_exists(working_directory + "extracted/"))
{
    directory_destroy(working_directory + "extracted/");
}


ds_map_destroy(dialogues);
ds_map_destroy(localized_texts);
ds_map_destroy(quests);
ds_map_destroy(dialogues_requirements);
dialogues = -1;
localized_texts = -1;
quests = -1;
dialogues_requirements = -1;