var search_data = {"index":{"searchIndex":["applicationcontroller","applicationrecord","availabilitiescontroller","availability","datetime","event","eventscoped","eventscontroller","eventshelper","task","taskscontroller","user","available_participants()","copydays()","create()","create()","destroy()","destroy()","destroy()","hour_12()","hour_24()","index()","index()","join()","leave()","load_event()","make()","new()","owns_event()","reformat_time()","show()","update()","readme","manifest.js","application.js","availabilities.coffee","cable.js","events.coffee","tasks.coffee","application.scss","availabilities.scss","events.scss","tasks.scss","rdoc.rake"],"longSearchIndex":["applicationcontroller","applicationrecord","availabilitiescontroller","availability","datetime","event","eventscoped","eventscontroller","eventshelper","task","taskscontroller","user","eventshelper#available_participants()","availabilitiescontroller#copydays()","eventscontroller#create()","taskscontroller#create()","availabilitiescontroller#destroy()","eventscontroller#destroy()","taskscontroller#destroy()","datetime#hour_12()","datetime#hour_24()","availabilitiescontroller#index()","eventscontroller#index()","availabilitiescontroller#join()","availabilitiescontroller#leave()","eventscoped#load_event()","availabilitiescontroller#make()","eventscontroller#new()","eventscoped#owns_event()","applicationcontroller#reformat_time()","eventscontroller#show()","taskscontroller#update()","","","","","","","","","","","",""],"info":[["ApplicationController","","ApplicationController.html","","<p>Provides common actions for the application\n"],["ApplicationRecord","","ApplicationRecord.html","","<p>Rails-generated base class for models\n"],["AvailabilitiesController","","AvailabilitiesController.html","","<p>Provides actions for /events/:event_id/availabilities/:id\n"],["Availability","","Availability.html","","<p>ActiveRecord model for Event time slots\n<p>Each Availablity &#39;belongs to&#39; an Event and a User.\n<p>If an …\n"],["DateTime","","DateTime.html","","<p>Provides extension methods for DateTime objects\n"],["Event","","Event.html","","<p>ActiveRecord model for events\n<p>Every Event belongs to an &#39;admin&#39; User, and has many availabilities\n…\n"],["EventScoped","","EventScoped.html","","<p>ActiveSupport::Concern for controllers that are scoped to a single Event\n"],["EventsController","","EventsController.html","","<p>Provides actions for /events and /events/:id\n"],["EventsHelper","","EventsHelper.html","","<p>Provides extra methods for use with Event objects\n"],["Task","","Task.html","","<p>ActiveRecord model for tasks\n<p>Belongs to an Event and optionally, an assigned User\n"],["TasksController","","TasksController.html","","<p>Provides actions for /events/:event_id/tasks/:id\n"],["User","","User.html","","<p>Devise model for users\n<p>User can have many Event and Availability.\n<p>If a user is destroyed, all of their …\n"],["available_participants","EventsHelper","EventsHelper.html#method-i-available_participants","(participants,event,time)","<p>Get a list of the participants available for a specified event at a\nspecified time.\n<p>PRE &mdash; all param objects …\n"],["copydays","AvailabilitiesController","AvailabilitiesController.html#method-i-copydays","()","<p>Copies availabilities from one day to a new one.\n<p>PRE &mdash; Days is after last availability in an event\n<p>POST &mdash; "],["create","EventsController","EventsController.html#method-i-create","()","<p>Define what to do when creating a new event\n<p>PRE &mdash; None\n<p>POST &mdash; A new event is created, and availabilities added. …\n"],["create","TasksController","TasksController.html#method-i-create","()","<p>Creates a new task in the database\n<p>PRE &mdash; None\n<p>POST &mdash; Either a task is created in the database, or an error …\n"],["destroy","AvailabilitiesController","AvailabilitiesController.html#method-i-destroy","()","<p>Destroys an availability\n<p>PRE &mdash; The availability exists\n<p>POST &mdash; The availability is removed from the database …\n"],["destroy","EventsController","EventsController.html#method-i-destroy","()","<p>Find and destroy an event. Redirect to events#index.\n<p>PRE &mdash; The event with the specific id exists\n<p>POST &mdash; The …\n"],["destroy","TasksController","TasksController.html#method-i-destroy","()","<p>Deletes a task from the database\n<p>PRE &mdash; The task is loaded\n<p>POST &mdash; Either the task is deleted if it existed, …\n"],["hour_12","DateTime","DateTime.html#method-i-hour_12","()","<p>Converts to 12-hour (civilian) time\n<p>PRE &mdash; None\n<p>POST &mdash; None\n"],["hour_24","DateTime","DateTime.html#method-i-hour_24","()","<p>Converts to 24-hour (military) time\n<p>PRE &mdash; None\n<p>POST &mdash; None\n"],["index","AvailabilitiesController","AvailabilitiesController.html#method-i-index","()","<p>Simply redirects back to home page. Required since refreshing after a\nfailed validation will bring you …\n"],["index","EventsController","EventsController.html#method-i-index","()","<p>Create an instance var of all of the events for use in the events#index\npage\n<p>PRE &mdash; None\n<p>POST &mdash; None\n"],["join","AvailabilitiesController","AvailabilitiesController.html#method-i-join","()","<p>Adds a user to an availability\n<p>PRE &mdash; None\n<p>POST &mdash; One more user will belong to an availability.\n"],["leave","AvailabilitiesController","AvailabilitiesController.html#method-i-leave","()","<p>Removes a user from an availability\n<p>PRE &mdash; None\n<p>POST &mdash; User specified will be free of his duty.\n"],["load_event","EventScoped","EventScoped.html#method-i-load_event","()","<p>Loads an Event instance into an instance variable @event\n<p>PRE &mdash; The params hash contains an :event_id key …\n"],["make","AvailabilitiesController","AvailabilitiesController.html#method-i-make","()","<p>Make more availabilities.\n<p>PRE &mdash; The new start time is after the last availability time.\n<p>POST &mdash; New availabilities …\n"],["new","EventsController","EventsController.html#method-i-new","()","<p>Create an instance var for a new event for the events#new pages\n<p>PRE &mdash; None\n<p>POST &mdash; An event object is created …\n"],["owns_event","EventScoped","EventScoped.html#method-i-owns_event","()","<p>Filters requests based on whether or not the current user owns the\nrequested event\n<p>PRE &mdash; A user is logged …\n"],["reformat_time","ApplicationController","ApplicationController.html#method-i-reformat_time","()","<p>Toggle the hour format to the opposite of what it was, then reload current\npage.\n<p>PRE &mdash; None\n<p>POST &mdash; Time is …\n"],["show","EventsController","EventsController.html#method-i-show","()","<p>Create an instance var of the event with the specified id for the\nevents#show page\n<p>PRE &mdash; None\n<p>POST &mdash; Shows …\n"],["update","TasksController","TasksController.html#method-i-update","()","<p>Updates a task in the database (used for both task assignment and name\nchange)\n<p>PRE &mdash; The task is loaded …\n"],["README","","README_md.html","","<p>Skeddit\n<p>Skeddit is a modular event planner and scheduler created in Ruby on Rails.\nIts simplistic design …\n"],["manifest.js","","app/assets/config/manifest_js.html","","<p>//= link_tree ../images //= link_directory ../javascripts .js //=\nlink_directory ../stylesheets .css …\n"],["application.js","","app/assets/javascripts/application_js.html","","<p>// This is a manifest file that&#39;ll be compiled into application.js,\nwhich will include all the files …\n"],["availabilities.coffee","","app/assets/javascripts/availabilities_coffee.html","","<p>Place all the behaviors and hooks related to the matching controller here.\nAll this logic will automatically …\n"],["cable.js","","app/assets/javascripts/cable_js.html","","<p>// Action Cable provides the framework to deal with WebSockets in Rails. //\nYou can generate new channels …\n"],["events.coffee","","app/assets/javascripts/events_coffee.html","","<p>Place all the behaviors and hooks related to the matching controller here.\nAll this logic will automatically …\n"],["tasks.coffee","","app/assets/javascripts/tasks_coffee.html","","<p>Place all the behaviors and hooks related to the matching controller here.\nAll this logic will automatically …\n"],["application.scss","","app/assets/stylesheets/application_scss.html","","\n<pre> This is a manifest file that&#39;ll be compiled into application.css, which will include all the files\n ...</pre>\n"],["availabilities.scss","","app/assets/stylesheets/availabilities_scss.html","","<p>// Place all the styles related to the Availabilities controller here. //\nThey will automatically be …\n"],["events.scss","","app/assets/stylesheets/events_scss.html","","<p>// Place all the styles related to the Event controller here. // They will\nautomatically be included …\n"],["tasks.scss","","app/assets/stylesheets/tasks_scss.html","","<p>// Place all the styles related to the Tasks controller here. // They will\nautomatically be included …\n"],["rdoc.rake","","lib/tasks/rdoc_rake.html","","<p>require &#39;rdoc/task&#39;\n<p>RDoc::Task.new do |rdoc|\n\n<pre>rdoc.rdoc_dir = &#39;documentation/full_app_documentation&#39; ...</pre>\n"]]}}