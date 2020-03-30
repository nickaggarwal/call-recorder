from django.contrib.auth.models import User
from rest_framework import serializers
from restapi.models import RecordCall
from django_filters import DateFilter, FilterSet

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'groups']


class RecordCallSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecordCall
        fields = '__all__'


class RecordCallItemFilter(FilterSet):
    start_date = DateFilter(field_name='date',lookup_expr='gte')
    end_date = DateFilter(field_name='date', lookup_expr='lte')

    class Meta:
        model = RecordCall
        fields = ['start_date', "end_date", "user_id"]