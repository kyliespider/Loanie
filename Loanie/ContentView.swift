import SwiftUI

enum AppTab: Hashable {
    case people
    case transactions
    case search
    case settings
    case add
}

struct ContentView: View {
    @State private var selectedTab: AppTab = .people
    @State private var previousTab: AppTab = .people
    @State private var showAddPane = false

    var body: some View {
        // Keep TabView at the root level so the native tab bar stays attached to the bottom.
        TabView(selection: $selectedTab) {
            Tab("People", systemImage: "person.crop.circle", value: .people) {
                CardViewPeople(color1: .blue)
            }
            Tab("Transactions", systemImage: "list.bullet.indent", value: .transactions) {
                CardView(title: Text("The transaction list will be here"), color: .orange)
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                CardView(
                    title: Text("Search will be here! \(Image(systemName: "face.smiling"))"),
                    color: .pink
                )
            }
            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                CardView(title: Text("Settings will be here"), color: .red)
            }

            // Prominent native action tab displayed separately on the trailing side.
            Tab("Add", systemImage: "plus.forwardslash.minus", value: .add, role: .prominent) {
                EmptyView()
            }
        }
        .tint(Color.accentColor)
        .onChange(of: selectedTab) { _, newTab in
            if newTab == .add {
                selectedTab = previousTab
                showAddPane = true
            } else {
                previousTab = newTab
            }
        }
        .sheet(isPresented: $showAddPane) {
            AddPane()
        }
        .tabViewStyle(.tabBarOnly)
    }
}
// hm
// Defines the screen presented by the Add action tab.
struct AddPane: View {
    @Environment(\.dismiss) private var dismiss
	@State private var transactionAmount = ""
	@FocusState private var isTransactionAmountFocused: Bool
	func closeAddPane() {
		dismiss()
		isTransactionAmountFocused = false
	}

    var body: some View {
        NavigationStack {
		   TextField("", text: $transactionAmount)
			   .textFieldStyle(.roundedBorder)
			   .font(.custom("Iosevka-Etoile-Extralight", size: 50))
			   .keyboardType(.decimalPad)
			   .focused($isTransactionAmountFocused)
                .navigationSubtitle("Add a transaction")
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()

                        } label: {
                            Image(systemName: "xmark")
                        }
                        .accessibilityLabel("Close")
                    }
                }
			 .task{
				 isTransactionAmountFocused = true
			 }
        }
    }
}

struct CardViewPeople: View {
    let color1: Color

    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(color1.gradient)
                    .overlay {
                        Text("People will be here")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding()
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Add person action will be wired here.
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.contrast)
                    }
                    .accessibilityLabel("Add person")
                }
            }
        }
    }
}

struct CardView: View {
    let title: Text
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(color.gradient)
            .overlay {
                title
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: 300, maxHeight: 300)
            .padding()
    }
}

#Preview {
    ContentView()
}
