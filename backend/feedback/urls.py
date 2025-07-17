from django.urls import path
from .views import feedback_api

urlpatterns = [
    path('api/feedback/', feedback_api),