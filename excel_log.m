function varargout = excel_log(varargin)
% EXCEL_LOG MATLAB code for excel_log.fig
%      EXCEL_LOG, by itself, creates a new EXCEL_LOG or raises the existing
%      singleton*.
%
%      H = EXCEL_LOG returns the handle to a new EXCEL_LOG or the handle to
%      the existing singleton*.
%
%      EXCEL_LOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXCEL_LOG.M with the given input arguments.
%
%      EXCEL_LOG('Property','Value',...) creates a new EXCEL_LOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before excel_log_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to excel_log_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help excel_log

% Last Modified by GUIDE v2.5 18-May-2017 21:35:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @excel_log_OpeningFcn, ...
                   'gui_OutputFcn',  @excel_log_OutputFcn, ...
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


% --- Executes just before excel_log is made visible.
function excel_log_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to excel_log (see VARARGIN)

% Choose default command line output for excel_log
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.edit1,'String','Welcome! Click on "CONNECT" to start');

% UIWAIT makes excel_log wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = excel_log_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'String','Connecting...');
clear a;
global a;
global temp;
a = arduino('COM7');
set(handles.edit1,'String','Connected');

% --- Executes on button press in disconnect.
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'String','Disconnected');
clear all;


% --- Executes on button press in acquire.
function acquire_Callback(hObject, eventdata, handles)
% hObject    handle to acquire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
global temp;
for i=1:10
    v = a.analogRead(0);
    temp(i) = (v/1024.0)*500;
    pause(1)
    set(handles.edit1,'String','Acquiring sensor data');
end
set(handles.edit1,'String','Acquisition Complete');
xlswrite('F:\test.xlsx',temp','Sheet1');

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k;
global temp;
k=size(temp,2);
set(handles.edit1,'String','Displaying graph');

figure(1)
plot(1:1:k,temp,'k--o','MarkerSize',10,'MarkerEdgeColor','b')
xlabel('Sample Number');
ylabel('Temperature (degC)');
