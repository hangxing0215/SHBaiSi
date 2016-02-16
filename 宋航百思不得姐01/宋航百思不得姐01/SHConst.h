#import <UIKit/UIKit.h>
/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const SHTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const SHTitilesViewY;
/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const SHTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const SHTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const SHTopicCellBottomBarH;
//图片显示的最高高度
UIKIT_EXTERN CGFloat const SHTopicPictureViewMaxH;
//超过最高高度显示的高度
UIKIT_EXTERN CGFloat const SHTopicPictureViewBreakH;

//最热评论显示的高度
UIKIT_EXTERN CGFloat const SHTopicTopCntLabelH;

/**
 *  用户模型 性别属性值
 
 */
UIKIT_EXTERN NSString *const SHUserSexMale;
UIKIT_EXTERN NSString *const SHUserSexFemale;

//tabbar发出的通知
UIKIT_EXTERN NSString * const SHTabbarDidSelectNotifation;


//1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef enum
{
    SHTopicTypeAll  = 1,
    SHTopicTypePicture  = 10,
    SHTopicTypeAudio  = 31,
    SHTopicTypeVideo  = 41,
    SHTopicTypeWord  = 29,
    
}SHTopicType;