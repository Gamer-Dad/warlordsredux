#include "constants.inc"

import RscListBox;

class WLCListBox: RscListBox {
    deletable = 0;
    canDrag = 0;
    color[] = {0, 1, 0, 1};
    colorBackground[] = {0, 0, 0, 1};
    colorSelect[] = {0, 0, 0, 1};
    colorSelectBackground[] = {1, 1, 1, 0.9};
    colorSelectBackground2[] = {1, 1, 1, 0.9};
    period = -1;
    type = CT_LISTBOX;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    class ListScrollBar{
        color[] = {1,1,1,1};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
    style = LB_TEXTURES;
};

class WLC_MenuUI {
    idd = WLC_DISPLAY;
    movingEnable = true;
    class controls {
        class WLC_Draggable: IGUIBackMRTM {
            idc = 12001;
            x = 0;
            y = -0.05;
            w = 1;
            h = 0.05;
            colorBackground[] = {0, 0, 0, 1};
            moving = 1;
        };
        class WLC_TitleBar: RscText {
            idc = -1;
            x = 0.05;
            y = -0.05;
            w = 0.9;
            h = 0.05;
            text = "Redux Customization Menu";
            style = ST_LEFT;
        };
        class WLC_Background: IGUIBackMRTM {
            idc = 12002;
            x = 0;
            y = 0;
            w = 1;
            h = 1;
            colorBackground[] = {0.2, 0.2, 0.2, 1};
        };
        class WLC_Frame: RscPicture {
            idc = -1;
            x = 0;
            y = -0.05;
            w = 1;
            h = 1.05;
            style = ST_PICTURE;
            colorText[] = {1, 1, 1, 1};
            text = "a3\ui_f\data\igui\rsctitles\interlacing\interlacing_ca.paa";
        };
        class WLC_CloseButton: RscCheckboxMRTM {
            idc = 12003;
            sizeEx = "0.021 / (getResolution select 5)";
            x = 1 - 0.0375;
            y = -0.05;
            w = 0.0375;
            h = 0.05;
            colorBackgroundHover[] = {1, 1, 1, 0.3};
            font = "PuristaMedium";
            textureUnChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureFocusedChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureFocusedUnchecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureHoverChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureHoverUnchecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            texturePressedChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            texturePressedUnchecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureDisabledChecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
            textureDisabledUnchecked = "\A3\ui_f\data\map\groupicons\waypoint.paa";
        };
        class WLC_Frame_T: RscPicture {
            idc = -1;
            x = 0;
            y = -0.1;
            w = 1;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_T_ca.paa";
            moving = 1;
        };
        class WLC_Frame_B: RscPicture {
            idc = -1;
            x = 0;
            y = 0.97;
            w = 1;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_B_ca.paa";
            moving = 1;
        };
        class WLC_Frame_L: RscPicture {
            idc = -1;
            x = -0.05;
            y = -0.05;
            w = 0.08;
            h = 1.05;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_L_ca.paa";
            moving = 1;
        };
        class WLC_Frame_R: RscPicture {
            idc = -1;
            x = 0.975;
            y = -0.05;
            w = 0.08;
            h = 1.05;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_R_ca.paa";
            moving = 1;
        };
        class WLC_Frame_TL: RscPicture {
            idc = -1;
            x = -0.05;
            y = -0.1;
            w = 0.08;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_TL_ca.paa";
            moving = 1;
        };
        class WLC_Frame_TR: RscPicture {
            idc = -1;
            x = 0.975;
            y = -0.1;
            w = 0.08;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_TR_ca.paa";
            moving = 1;
        };
        class WLC_Frame_BL: RscPicture {
            idc = -1;
            x = -0.05;
            y = 0.97;
            w = 0.08;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_BL_ca.paa";
            moving = 1;
        };
        class WLC_Frame_BR: RscPicture {
            idc = -1;
            x = 0.975;
            y = 0.97;
            w = 0.08;
            h = 0.08;
            style = ST_PICTURE;
            text = "A3\ui_f\data\GUI\Rsc\RscMiniMapSmall\GPS_BR_ca.paa";
            moving = 1;
        };

        class WLC_PrimarySelectLabel: RscText {
            idc = -1;
            text = "Primary";
            x = 0.015;
            y = 0.01;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_PrimarySelect: WLCListBox {
            idc = WLC_PRIMARY_SELECT;
			x = 0.015;
			y = 0.075;
			w = 0.3;
			h = 0.4;
        };

        class WLC_SecondarySelectLabel: RscText {
            idc = -1;
            text = "Secondary";
            x = 0.345;
            y = 0.01;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_SecondarySelect: WLCListBox {
            idc = WLC_SECONDARY_SELECT;
            x = 0.345;
            y = 0.075;
            w = 0.3;
            h = 0.4;
        };

        class WLC_LauncherSelectLabel: RscText {
            idc = -1;
            text = "Launcher";
            x = 0.675;
            y = 0.01;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_LauncherSelect: WLCListBox {
            idc = WLC_LAUNCHER_SELECT;
            x = 0.675;
            y = 0.075;
            w = 0.3;
            h = 0.4;
        };

        class WLC_UniformSelectLabel: RscText {
            idc = -1;
            text = "Uniform";
            x = 0.015;
            y = 0.51;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_UniformSelect: WLCListBox {
            idc = WLC_UNIFORM_SELECT;
            x = 0.015;
            y = 0.575;
            w = 0.3;
            h = 0.4;
        };

        class WLC_VestSelectLabel: RscText {
            idc = -1;
            text = "Vest";
            x = 0.345;
            y = 0.51;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_VestSelect: WLCListBox {
            idc = WLC_VEST_SELECT;
            x = 0.345;
            y = 0.575;
            w = 0.3;
            h = 0.4;
        };

        class WLC_HelmetSelectLabel: RscText {
            idc = -1;
            text = "Helmet";
            x = 0.675;
            y = 0.51;
            w = 0.3;
            h = 0.05;
            style = ST_CENTER;
            sizeEx = 0.05;
        };
        class WLC_HelmetSelect: WLCListBox {
            idc = WLC_HELMET_SELECT;
            x = 0.675;
            y = 0.575;
            w = 0.3;
            h = 0.4;
        };

        class WLC_LevelDisplay: RscText {
            idc = WLC_LEVEL_TEXT;
            x = 0;
            y = -0.05;
            w = 1;
            h = 0.05;
            style = ST_CENTER;
        };
    };
};