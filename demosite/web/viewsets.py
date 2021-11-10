from rest_framework import viewsets

from web.models import Pokemon
from web.serializers import PokemonSerializer

# Create your views here.
# ViewSets define the view behavior.
class PokemonViewSet(viewsets.ModelViewSet):
    queryset = Pokemon.objects.all()
    serializer_class = PokemonSerializer
