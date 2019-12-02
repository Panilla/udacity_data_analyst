import time
import pandas as pd
import numpy as np

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york city': 'new_york_city.csv',
              'washington': 'washington.csv' }

def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    print('Hello! Let\'s explore some US bikeshare data!')
    # TO DO: get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    city_options = ['chicago', 'new york city', 'washington']
    while True:
            city = input("Enter either chicago, new york city, or washington (in lowercase):")
            if city in city_options:
                break
            else:
                print("I'm sorry, I didn't understand that. Please try again.")

    # TO DO: get user input for month (all, january, february, ... , june)
    month_options = ['all', 'january', 'february', 'march', 'april', 'june']
    while True:
        month = input("Enter a month between january and june, or enter the word \"all\" (in lowercase):")
        if month in month_options:
            break
        else:
            print("I'm sorry, I didn't understand that. Please try again.")
    # TO DO: get user input for day of week (all, monday, tuesday, ... sunday)
    day_options = ['all', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    while True:
        day = input("Enter a day of the week, or the word \"all\" (in lowercase):")
        if day in day_options:
            break
        else:
            print("Sorry, I didn't understand that, please try again.")


    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """
    # load data file into a dataframe
    df = pd.read_csv(CITY_DATA[city])

    # convert the Start Time column to datetime
    df['Start Time'] = pd.to_datetime(df['Start Time'])

    # extract hour from the Start Time column to create an hour column
    df['hour'] = df['Start Time'].dt.hour

    # extract month and day of week from Start Time to create new columns
    df['month'] = df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.weekday_name

    # filter by month if applicable
    if month != 'all':
        # use the index of the months list to get the corresponding int
        months = ['january', 'february', 'march', 'april', 'may', 'june']
        month = months.index(month) + 1

        # filter by month to create the new dataframe
        df = df[df['month'] == month]

    # filter by day of week if applicable
    if day != 'all':
        # filter by day of week to create the new dataframe
        df = df[df['day_of_week'] == day.title()]

    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # TO DO: display the most common month
    popular_month = df['month'].mode()[0]
    print('Most Frequent Month:', popular_month)

    # TO DO: display the most common day of week
    popular_week = df['day_of_week'].mode()[0]
    print('Most Frequent Day of the Week:', popular_week)

    # TO DO: display the most common start hour
    popular_hour = df['hour'].mode()[0]
    print('Most Frequent Start Hour:', popular_hour)


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # TO DO: display most commonly used start station
    popular_start = df['Start Station'].mode()[0]
    print('Most Frequent Start Station:', popular_start)

    # TO DO: display most commonly used end station
    popular_end = df['End Station'].mode()[0]
    print('Most Frequent End Station:', popular_end)

    # TO DO: display most frequent combination of start station and end station trip
    df['Popular Trip']=df['Start Station']+', '+df['End Station']
    popular_trip = df['Popular Trip'].mode()[0]
    print('Most Frequent Combination of Start Station and End Station Trip:', popular_trip)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # TO DO: display total travel time
    travel_total = df['Trip Duration'].sum()
    print('Total Travel Time:', travel_total)

    # TO DO: display mean travel time
    travel_avg = df['Trip Duration'].mean()
    print('Average Travel Time:', travel_avg)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # TO DO: Display counts of user types
    df['User Type'] = df['User Type'].replace('Dependent',np.nan)
    user_type = df['User Type'].dropna(axis = 0).value_counts()
    print('Total of Each User Type:\n', user_type)

    # TO DO: Display counts of gender
    while True:
        if 'Gender' in df:
            gender = df['Gender'].value_counts()
            print('Total Male and Female Users:\n', gender)
            break
        else:
            print("\nGender not present in data.")
            break
    # TO DO: Display earliest, most recent, and most common year of birth
    while True:
        if 'Birth Year' in df:
            birth_min = df['Birth Year'].dropna(axis = 0).min().astype(int)
            print('Earliest Birth Year:', birth_min)

            birth_max = df['Birth Year'].max().astype(int)
            print('Most Recent Birth Year:', birth_max)

            birth_mode = df['Birth Year'].mode()[0].astype(int)
            print('Most Common Birth Year:', birth_mode)
            break
        else:
            print("\nBirth Year not present in data.")
            break


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break


if __name__ == "__main__":
	main()
