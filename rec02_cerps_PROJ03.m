% IMPLEMENTED FIX FOR EXTRA CREDIT
function varargout = rec02_cerps_PROJ03(varargin)
global I;
global path;
% REC02_CERPS_PROJ03 M-file for rec02_cerps_PROJ03.fig
%      REC02_CERPS_PROJ03, by itself, creates a new REC02_CERPS_PROJ03 or raises the existing
%      singleton*.
%
%      H = REC02_CERPS_PROJ03 returns the handle to a new REC02_CERPS_PROJ03 or the handle to
%      the existing singleton*.
%
%      REC02_CERPS_PROJ03('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REC02_CERPS_PROJ03.M with the given input arguments.
%
%      REC02_CERPS_PROJ03('Property','Value',...) creates a new REC02_CERPS_PROJ03 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rec02_cerps_PROJ03_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rec02_cerps_PROJ03_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rec02_cerps_PROJ03

% Last Modified by GUIDE v2.5 16-Nov-2010 13:14:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rec02_cerps_PROJ03_OpeningFcn, ...
                   'gui_OutputFcn',  @rec02_cerps_PROJ03_OutputFcn, ...
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


% --- Executes just before rec02_cerps_PROJ03 is made visible.
function rec02_cerps_PROJ03_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rec02_cerps_PROJ03 (see VARARGIN)

% Choose default command line output for rec02_cerps_PROJ03
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rec02_cerps_PROJ03 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rec02_cerps_PROJ03_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function imagename_edittext_Callback(hObject, eventdata, handles)
% hObject    handle to imagename_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagename_edittext as text
%        str2double(get(hObject,'String')) returns contents of imagename_edittext as a double



% --- Executes during object creation, after setting all properties.
function imagename_edittext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagename_edittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showimage_pushbutton.
function showimage_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to showimage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
global existpath
name = get(handles.imagename_edittext,'String');
currentdir = pwd;
path = [currentdir, '\', name];
existpath = exist(path);
if existpath == 0
    set(handles.imagename_edittext,'String', 'Wrong File Name: Enter New Name');
    cla reset;
    set(handles.processingoptions_popupmenu,'Value', 1);
else
cla reset;
I = imread(path);
imshow(I)
end
guidata(hObject, handles);


% --- Executes on selection change in processingoptions_popupmenu.
function processingoptions_popupmenu_Callback(hObject, eventdata, handles)
global I
global existpath
% hObject    handle to processingoptions_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns processingoptions_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        processingoptions_popupmenu
if existpath == 0 && get(handles.processingoptions_popupmenu,'Value') ~= 1
else
switch get(handles.processingoptions_popupmenu,'Value')
    case 1
        imshow(I);
        %{
        This process simply displays the original image since there is no need for any image processing 
        to be done.
        %}
    case 2
        h = fspecial('gaussian', 7, 5);
        processedImage = imfilter(I,h,'replicate');
        hAxes = gca;
        imshow(processedImage,'Parent',hAxes);
        %{
        This applies a rotationally symmetric Gaussian low-pass filter which is of size 7 (ie: a 7 x 7 matrix), 
        and has a standard deviation applied to it (in this case, 5).
        %}
        %{
        The code hAxes = gca; and imshow(processedImage,'Parent',hAxes); works by defining the hAxes variable as
        the handle for the current axis being used in the figure(this is equivalent to using get(gcf,'CurrentAxes')).
        The second line of code is a composite function.  imshow is the function used to display the image.
        processedImage represents the variable name of the outputted image after the filter is applied. 
       'Parent' represents the handle of an axes that determines the parent of the image that will be 
        generated by the imshow function.  Finally, hAxes is the variable that was defined before to tell the imshow
        function on which axis to display the output image.
        %}
    case 3
        gray = rgb2gray(I);
        processedImage = edge(gray);
        hAxes = gca;
        imshow(processedImage,'Parent',hAxes);
        %{
        This first converts the image from color to grayscale (Takes the RGB values and makes them equal to 0
        so the image is grayscale).  Following that, the Sobel horizontal edge-emphasizing filter is applied 
        which emphasizes the horizontal edges of the image using the smoothing effect by approximating a vertical
        gradient.
        %}
        %{
        The code hAxes = gca; and imshow(processedImage,'Parent',hAxes); works by defining the hAxes variable as
        the handle for the current axis being used in the figure(this is equivalent to using get(gcf,'CurrentAxes')).
        The second line of code is a composite function.  imshow is the function used to display the image.
        processedImage represents the variable name of the outputted image after the filter is applied. 
       'Parent' represents the handle of an axes that determines the parent of the image that will be 
        generated by the imshow function.  Finally, hAxes is the variable that was defined before to tell the imshow
        function on which axis to display the output image.
        %}
    case 4
        h = fspecial('unsharp');
        processedImage = imfilter(I,h,'replicate');
        hAxes = gca;
        imshow(processedImage,'Parent',hAxes);
        %{
        This creates an unsharp contrast enhancement filter using the negative of the Laplacian filter 
        with the default parameter of 0.2 being applied and applying this filter (stored as an array) to the
        original image (also stored as an array).  The replicate parameter takes the input array values outside
        the bounds of the array and assumes them to be equal to the nearest array border value.
        %}
        %{
        The code hAxes = gca; and imshow(processedImage,'Parent',hAxes); works by defining the hAxes variable as
        the handle for the current axis being used in the figure(this is equivalent to using get(gcf,'CurrentAxes')).
        The second line of code is a composite function.  imshow is the function used to display the image.
        processedImage represents the variable name of the outputted image after the filter is applied. 
       'Parent' represents the handle of an axes that determines the parent of the image that will be 
        generated by the imshow function.  Finally, hAxes is the variable that was defined before to tell the imshow
        function on which axis to display the output image.
        %}
    case 5
        horizontalKernel = [-1,-1,-1;2,2,2;-1,-1,-1];
        processedImage = imfilter(I, horizontalKernel);
        hAxes = gca;
        imshow(processedImage,'Parent',hAxes);
        %{
        This uses line detection, a form of edge detection to detect if there is a major change in color 
        in the horizontal direction.  It utilizes the above defined array to restrict the edge detection 
        to the above values and then adjusts the image output accordingly.
        %}
        %{
        The code hAxes = gca; and imshow(processedImage,'Parent',hAxes); works by defining the hAxes variable as
        the handle for the current axis being used in the figure(this is equivalent to using get(gcf,'CurrentAxes')).
        The second line of code is a composite function.  imshow is the function used to display the image.
        processedImage represents the variable name of the outputted image after the filter is applied. 
       'Parent' represents the handle of an axes that determines the parent of the image that will be 
        generated by the imshow function.  Finally, hAxes is the variable that was defined before to tell the imshow
        function on which axis to display the output image.
        %}
    case 6
        processedImage = im2bw(I,0.5);
        hAxes = gca;
        imshow(processedImage,'Parent',hAxes);
        %{
        This converts the image to binary by replacing all of the pixels in the input image with a luminance
        greater than the threshold (in this case, 0.5) with a value of 1 to make the pixel white, and anything
        else with 0 to make the pixel black.        
        %}
        %{
        The code hAxes = gca; and imshow(processedImage,'Parent',hAxes); works by defining the hAxes variable as
        the handle for the current axis being used in the figure(this is equivalent to using get(gcf,'CurrentAxes')).
        The second line of code is a composite function.  imshow is the function used to display the image.
        processedImage represents the variable name of the outputted image after the filter is applied. 
       'Parent' represents the handle of an axes that determines the parent of the image that will be 
        generated by the imshow function.  Finally, hAxes is the variable that was defined before to tell the imshow
        function on which axis to display the output image.
        %}
end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function processingoptions_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processingoptions_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
