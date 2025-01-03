////////////////////////////////////////////////////////////////////////////////////////////////////
// NoesisGUI - http://www.noesisengine.com
// Copyright (c) 2013 Noesis Technologies S.L. All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////


#ifndef __GUI_SKEWTRANSFORM_H__
#define __GUI_SKEWTRANSFORM_H__


#include <NsCore/Noesis.h>
#include <NsGui/Transform.h>


namespace Noesis
{

////////////////////////////////////////////////////////////////////////////////////////////////////
/// Represents a 2D skew. It is useful for creating the illusion of 3-dimensional
/// depth in a 2D object.
///
/// http://msdn.microsoft.com/en-us/library/system.windows.media.skewtransform.aspx
////////////////////////////////////////////////////////////////////////////////////////////////////
class NS_GUI_CORE_API SkewTransform final: public Transform
{
public:
    SkewTransform();
    SkewTransform(float angleX, float angleY);
    ~SkewTransform();

    NS_DECLARE_POOL_ALLOCATOR

    /// Gets or sets the x-axis skew angle, which is measured in degrees counterclockwise from
    /// the y-axis
    //@{
    float GetAngleX() const;
    void SetAngleX(float angleX);
    //@}

    /// Gets or sets the y-axis skew angle, which is measured in degrees counterclockwise from
    /// the x-axis
    //@{
    float GetAngleY() const;
    void SetAngleY(float angleY);
    //@}

    ///Gets or sets the x-coordinate of the transform center
    //@{
    float GetCenterX() const;
    void SetCenterX(float centerX);
    //@}

    /// Gets or sets the y-coordinate of the transform center
    //@{
    float GetCenterY() const;
    void SetCenterY(float centerY);
    //@}

    /// Hides Freezable methods for convenience
    //@{
    Ptr<SkewTransform> Clone() const;
    Ptr<SkewTransform> CloneCurrentValue() const;
    //@}

public:
    /// Dependency properties
    //@{
    static const DependencyProperty* AngleXProperty;
    static const DependencyProperty* AngleYProperty;
    static const DependencyProperty* CenterXProperty;
    static const DependencyProperty* CenterYProperty;
    //@}

protected:
    /// From Freezable
    //@{
    Ptr<Freezable> CreateInstanceCore() const override;
    //@}

    NS_DECLARE_REFLECTION(SkewTransform, Transform)
};

}

#endif
