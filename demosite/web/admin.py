from django.contrib import admin
from web.models import Pokemon

class PokemonAdmin(admin.ModelAdmin):
    search_fields = ('name',)

    list_display = (
        'number', 'name', 'type1', 'type2', 'generation', 'legendary', 
        )

    list_filter = (
        'type1', 'type2', 'generation', 'legendary',
    )

    fieldsets = (
        (None, {
            'fields': ('name', 'number', 'type1', 'type2', 'generation', 'legendary')
        }),
        ('Stats', {
            'fields': ('hp', 'speed', 'attack', 'sp_atk', 'defense', 'sp_def', ),
        }),
    )    

admin.site.register(Pokemon, PokemonAdmin)
