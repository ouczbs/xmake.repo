////////////////////////////////////////////////////////////////////////////////////////////////////
// NoesisGUI - http://www.noesisengine.com
// Copyright (c) 2013 Noesis Technologies S.L. All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////


#ifndef __GUI_PANEL_H__
#define __GUI_PANEL_H__


#include <NsCore/Noesis.h>
#include <NsGui/FrameworkElement.h>


namespace Noesis
{

class UIElementCollection;
class ItemsControl;
class ItemContainerGenerator;
class RectangleGeometry;
struct ItemsChangedEventArgs;
struct GeneratorPosition;

NS_WARNING_PUSH
NS_MSVC_WARNING_DISABLE(4251 4275)

////////////////////////////////////////////////////////////////////////////////////////////////////
/// Provides a base class for all Panel elements. Use Panel elements to position and arrange child
/// objects.
///
/// .. code-block:: xml
///    :caption: XAML
///
///    <Page xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation">
///      <StackPanel>
///        <Button>Button 1</Button>
///        <Button>Button 2</Button>
///      </StackPanel>
///    </Page>
///
/// Panel contains a collection of UIElement objects, which are in the Children property. Adding a
/// UIElement child to a Panel implicitly adds it to the UIElementCollection for the Panel element.
///
/// Panel elements do not receive mouse events if a Background is not defined. If you need to handle
/// mouse events but do not want a background for your Panel, use Transparent.
///
/// http://msdn.microsoft.com/en-us/library/system.windows.controls.panel.aspx
////////////////////////////////////////////////////////////////////////////////////////////////////
class NS_GUI_CORE_API Panel: public FrameworkElement
{
public:
    Panel();
    Panel(const Panel&) = delete;
    Panel& operator=(const Panel&) = delete;
    virtual ~Panel() = 0;

    /// Gets or sets panel background
    //@{
    Brush* GetBackground() const;
    void SetBackground(Brush* brush);
    //@}

    /// Gets or sets a value that indicates that this Panel is a container for user interface (UI) 
    /// items that are generated by an ItemsControl.
    //@{
    bool GetIsItemsHost() const;
    void SetIsItemsHost(bool value);
    //@}

    /// Gets or sets a value that represents the order on the z-plane in which an element appears
    //@{
    static int32_t GetZIndex(const DependencyObject* element);
    static void SetZIndex(DependencyObject* element, int32_t value);
    //@}

    /// Gets children collection
    /// \prop
    UIElementCollection* GetChildren() const;

public:
    /// Dependency properties
    //@{
    static const DependencyProperty* BackgroundProperty;
    static const DependencyProperty* IsItemsHostProperty;
    static const DependencyProperty* ZIndexProperty; // attached property
    //@}

protected:
    UIElementCollection* GetInternalChildren() const;

    void EnsureGenerator();
    ItemContainerGenerator* GetGenerator() const;

    // Creates children collection
    virtual Ptr<UIElementCollection> CreateChildrenCollection(FrameworkElement* logicalParent);

    // Generates item containers hosted in this panel
    virtual void GenerateChildren();

    // Updates children when items changed
    virtual void OnItemsChangedOverride(BaseComponent* sender,
        const ItemsChangedEventArgs& e);

    virtual void OnConnectToGenerator(ItemsControl* itemsControl);
    virtual void OnDisconnectFromGenerator();

    /// From DependencyObject
    //@{
    void OnInit() override;
    bool OnPropertyChanged(const DependencyPropertyChangedEventArgs& args) override;
    //@}

    /// From Visual
    //@{
    uint32_t GetVisualChildrenCount() const override;
    Visual* GetVisualChild(uint32_t index) const override;
    void OnVisualChildrenChanged(Visual* added, Visual* removed) override;
    //@}

    /// From UIElement
    //@{
    void OnRender(DrawingContext* context) override;
    //@}

    /// From FrameworkElement
    //@{
    void CloneOverride(FrameworkElement* clone, FrameworkTemplate* template_) const override;
    uint32_t GetLogicalChildrenCount() const override;
    Ptr<BaseComponent> GetLogicalChild(uint32_t index) const override;
    void OnTemplatedParentChanged(FrameworkElement* oldParent,
        FrameworkElement* newParent) override;
    //@}

private:
    /// Updates Z-order indirection vector taking into account children elements ZIndex
    void UpdateChildrenZOrder();
    void InvalidateZOrder();

    void EnsureChildrenCollection(FrameworkElement* logicalParent);

    void ConnectToGenerator();
    void DisconnectFromGenerator();

    friend class ItemsControl;
    void Refresh();

    void OnItemsChanged(BaseComponent* sender, const ItemsChangedEventArgs& e);

    void OnAddItem(const GeneratorPosition& position, int numItems);
    void OnRemoveItem(const GeneratorPosition& position, int numContainers);
    void OnReplaceItem(const GeneratorPosition& position, int numItems, int numContainers);
    void OnMoveItem(const GeneratorPosition& from, const GeneratorPosition& to,
        int numContainers);
    void OnResetItems();

private:
    // Collection of child elements of this panel
    Ptr<UIElementCollection> mInternalChildren;

    // Item container generator when Panel is the items host of an ItemsControl
    Ptr<ItemContainerGenerator> mItemContainerGenerator;

    Ptr<RectangleGeometry> mBackgroundGeometry;

    typedef Vector<uint32_t> ZOrderVector;
    ZOrderVector mZOrder;

    bool mValidZOrder;
    bool mIsValidItemsHost;

    NS_DECLARE_REFLECTION(Panel, FrameworkElement)
};

NS_WARNING_POP

}


#endif
