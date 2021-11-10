from rest_framework import serializers

from web.models import Pokemon

# Serializers define the API representation.
class PokemonSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Pokemon
        fields = ['number', 'name', 'type1', 'type2', 'generation', 'legendary']