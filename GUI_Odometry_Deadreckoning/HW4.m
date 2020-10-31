function varargout = HW4(varargin)
% HW4 MATLAB code for HW4.fig
%      HW4, by itself, creates a new HW4 or raises the existing
%      singleton*.
%
%      H = HW4 returns the handle to a new HW4 or the handle to
%      the existing singleton*.
%
%      HW4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW4.M with the given input arguments.
%
%      HW4('Property','Value',...) creates a new HW4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HW4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HW4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HW4

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HW4_OpeningFcn, ...
                   'gui_OutputFcn',  @HW4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HW4 is made visible.
function HW4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HW4 (see VARARGIN)

% Choose default command line output for HW4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HW4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(hObject,'toolbar','figure');

% --- Outputs from this function are returned to the command line.
function varargout = HW4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% alpha1_slider input
% --- Executes on alpha1_slider movement.
function alpha1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of alpha1_slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of alpha1_slider
sliderValue=get(handles.alpha1_slider,'Value');
set(handles.alpha1_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: alpha1_slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% result of alpha1_slider
function alpha1_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha1_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha1_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha1_editText as a double
sliderValue=get(handles.alpha1_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.slider1,'Value',0);
    set(handles.alpha1_editText,'String','0');
else
    set(handles.alpha1_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha1_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha1_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% alpha2
function alpha2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.alpha2_slider,'Value');
set(handles.alpha2_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alpha2_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha2_editText as a double
sliderValue=get(handles.alpha2_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.slider2,'Value',0);
    set(handles.alpha2_editText,'String','0');
else
    set(handles.alpha2_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha2_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% alpha3
% --- Executes on slider movement.
function alpha3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.alpha3_slider,'Value');
set(handles.alpha3_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alpha3_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha2_editText as a double
sliderValue=get(handles.alpha3_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.slider3,'Value',0);
    set(handles.alpha3_editText,'String','0');
else
    set(handles.alpha3_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha3_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% alpha4
% --- Executes on slider movement.
function alpha4_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.alpha4_slider,'Value');
set(handles.alpha4_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha4_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alpha4_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha2_editText as a double
sliderValue=get(handles.alpha4_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.slider4,'Value',0);
    set(handles.alpha4_editText,'String','0');
else
    set(handles.alpha4_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha4_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% alpha5
% --- Executes on slider movement.
function alpha5_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.alpha5_slider,'Value');
set(handles.alpha5_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha5_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alpha5_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha2_editText as a double
sliderValue=get(handles.alpha5_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.alpha4_slider,'Value',0);
    set(handles.alpha5_editText,'String','0');
else
    set(handles.alpha5_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha5_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% alpha6
% --- Executes on slider movement.
function alpha6_slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.alpha6_slider,'Value');
set(handles.alpha6_editText,'String',num2str(sliderValue))
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alpha6_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alpha6_editText_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_editText as text
%        str2double(get(hObject,'String')) returns contents of alpha2_editText as a double
sliderValue=get(handles.alpha6_editText,'String');
sliderValue=str2num(sliderValue);

if (isempty(sliderValue)||sliderValue<0||sliderValue>1)
    set(handles.alpha5_slider,'Value',0);
    set(handles.alpha6_editText,'String','0');
else
    set(handles.alpha6_slider,'Value',sliderValue);
end

% --- Executes during object creation, after setting all properties.
function alpha6_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
% Get user input from GUI

alpha1=get(handles.alpha1_slider,'Value');
alpha2=get(handles.alpha2_slider,'Value');
alpha3=get(handles.alpha3_slider,'Value');
alpha4=get(handles.alpha4_slider,'Value');
alpha5=get(handles.alpha5_slider,'Value');
alpha6=get(handles.alpha6_slider,'Value');

sample_number=get(handles.sample_number_editText,'String');
sample_number=str2num(sample_number)

radius=get(handles.radius_editText,'String');
r=str2num(radius)

step_number=get(handles.steps_editText,'String');
step_number=str2num(step_number)

IncX=get(handles.IncX_editText,'String');
IncX=str2num(IncX)

IncY=get(handles.IncY_editText,'String');
IncY=str2num(IncY)

a=get(handles.Model_menu,'value'); % deadreckoning-odometry
b=get(handles.Show_menu,'value');  % directevaluation-sampling
c=get(handles.Trajectory_menu,'value'); % circular-rectangular
d=get(handles.Distribution_menu,'value'); % normal-triangular
n=[0:.01:10];
if (a==1)&&(b==1)&&(c==1)
     deadreckoning_direct_circular
     set(handles.alpha5_slider,'enable','on');
     set(handles.alpha6_slider,'enable','on');
elseif (a==1)&&(b==1)&&(c==2)
     %b_deadreckoning_directevaluation_rectangular
     title('This is not in the homework')
elseif (a==1)&&(b==2)&&(c==1)
     c_deadreckoning_sampling_circular
elseif (a==1)&&(b==2)&&(c==2)
     % d_deadreckoning_sampling_rectangular   
     title('This is not in the homework')
elseif (a==2)&&(b==1)&&(c==1)
     odometry_direct_circular
     set(handles.alpha5_slider,'enable','off');
     set(handles.alpha6_slider,'enable','off');
elseif (a==2)&&(b==1)&&(c==2)
     %f_odometry_directevaluation_rectangular
     title('This is not completed')
elseif (a==2)&&(b==2)&&(c==1)
     g_odometry_sampling_circular
else
     h_odometry_sampling_rectangular
end
xlabel('X data');
ylabel('Y data');
guidata(hObject,handles); % updates the handles

% --- Executes on selection change in Model_menu.
function Model_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Model_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Model_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Model_menu


% --- Executes during object creation, after setting all properties.
function Model_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Model_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Show_menu.
function Show_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Show_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Show_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Show_menu


% --- Executes during object creation, after setting all properties.
function Show_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Show_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Trajectory_menu.
function Trajectory_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Trajectory_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Trajectory_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Trajectory_menu


% --- Executes during object creation, after setting all properties.
function Trajectory_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trajectory_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Distribution_menu.
function Distribution_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Distribution_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Distribution_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Distribution_menu


% --- Executes during object creation, after setting all properties.
function Distribution_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Distribution_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample_number_editText_Callback(hObject, eventdata, handles)
% hObject    handle to sample_number_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of sample_number_editText as text
%        str2double(get(hObject,'String')) returns contents of sample_number_editText as a double
% storc the contents of input1_editText as a string. if the string
% is not a number then input will be empty
input =str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
    set(hObject,'String','0')
end

% --- Executes during object creation, after setting all properties.
function sample_number_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_number_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_editText_Callback(hObject, eventdata, handles)
% hObject    handle to radius_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_editText as text
%        str2double(get(hObject,'String')) returns contents of radius_editText as a double
input =str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
    set(hObject,'String','0')
end

% --- Executes during object creation, after setting all properties.
function radius_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function steps_editText_Callback(hObject, eventdata, handles)
% hObject    handle to steps_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of steps_editText as text
%        str2double(get(hObject,'String')) returns contents of steps_editText as a double
input =str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
    set(hObject,'String','0')
end

% --- Executes during object creation, after setting all properties.
function steps_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steps_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IncX_editText_Callback(hObject, eventdata, handles)
% hObject    handle to IncX_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IncX_editText as text
%        str2double(get(hObject,'String')) returns contents of IncX_editText as a double
input =str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
    set(hObject,'String','0')
end

% --- Executes during object creation, after setting all properties.
function IncX_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IncX_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IncY_editText_Callback(hObject, eventdata, handles)
% hObject    handle to IncY_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IncY_editText as text
%        str2double(get(hObject,'String')) returns contents of IncY_editText as a double
input =str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
    set(hObject,'String','0')
end

% --- Executes during object creation, after setting all properties.
function IncY_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IncY_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end