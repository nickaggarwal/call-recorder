from django.db import models

# Create your models here.


class BaseModel(models.Model):
    id = models.AutoField(primary_key=True)
    created_at = models.DateTimeField(auto_now_add=True, auto_created=True)
    updated_at = models.DateTimeField(auto_now=True, auto_created=True)

    class Meta:
        abstract = True


class RecordCall(BaseModel):
    user_id = models.IntegerField(default=0)
    phoneNumber = models.CharField(max_length=256, blank=False, null=False)
    duration = models.IntegerField(default=0)
    date = models.DateTimeField()
    mediaUrl = models.CharField(max_length=256, blank=False, null=False)
    callType = models.IntegerField(default=0)