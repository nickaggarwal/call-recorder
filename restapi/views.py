from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from restapi.serializers import UserSerializer, RecordCallSerializer, RecordCallItemFilter
from restapi.models import RecordCall
from django_filters import rest_framework as filters

class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]


class RecordCallViewset(viewsets.ModelViewSet):
    queryset = RecordCall.objects.all()
    serializer_class = RecordCallSerializer
    filter_class = RecordCallItemFilter
    filter_backends = (filters.DjangoFilterBackend, )
    ordering_fields = '__all__'


